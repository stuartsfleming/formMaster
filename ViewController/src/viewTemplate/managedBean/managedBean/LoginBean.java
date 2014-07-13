package viewTemplate.managedBean.managedBean;


import java.io.IOException;

import java.util.Map;

import javax.faces.application.FacesMessage;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;

import javax.security.auth.Subject;
import javax.security.auth.callback.CallbackHandler;
import javax.security.auth.login.FailedLoginException;
import javax.security.auth.login.LoginException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import oracle.adf.share.ADFContext;
import oracle.adf.view.rich.event.DialogEvent;

import weblogic.security.SimpleCallbackHandler;
import weblogic.security.URLCallbackHandler;
import weblogic.security.services.Authentication;

import weblogic.servlet.security.ServletAuthentication;


public class LoginBean {

    String _username = null;
    String _password = null;
    
    public static String USERNAMETOKEN = "_____demoOnlyUsernameAttrString___________";
    public static String PASSWORDTOKEN = "_____demoOnlyPasswordAttrString___________";

    public LoginBean() {
        super();
    }

    public void setUsername(String _username) {
        this._username = _username;
    }

    public String getUsername() {
        return _username;
    }

    public void setPassword(String _password) {
        this._password = _password;
    }

    public String getPassword() {
        return _password;
    }
    
  public void onLoginAction(DialogEvent dialogEvent) {
      if (dialogEvent.getOutcome()== DialogEvent.Outcome.ok ){
        doLogin();
      }
      else{
        //cancel, do nothing
      }
  }
  
  private String doLogin() {
      String un = _username;
      byte[] pw = _password.getBytes();
      FacesContext ctx = FacesContext.getCurrentInstance();
      HttpServletRequest request = (HttpServletRequest)ctx.getExternalContext().getRequest();
      try {          
          CallbackHandler handler = new URLCallbackHandler(un,pw);
          Subject mySubject = weblogic.security.services.Authentication.login(handler);
          weblogic.servlet.security.ServletAuthentication.runAs(mySubject, request);
          ServletAuthentication.generateNewSessionID(request);
          
          //save username and password. Note that in a real application this is
          //*NOT* what you should do unencrypted. Note that this is a demo
          
          //Store username , password in session for later use
          //when connecting to Twitter
          ADFContext adfctx = ADFContext.getCurrent();
          Map sessionScope = adfctx.getSessionScope();
          sessionScope.put(this.USERNAMETOKEN, un);
          sessionScope.put(this.PASSWORDTOKEN, new String(pw));
          
          String loginUrl = "/adfAuthentication?success_url=/faces" + ctx.getViewRoot().getViewId();
          HttpServletResponse response = (HttpServletResponse)ctx.getExternalContext().getResponse();
          sendForward(request, response, loginUrl);
      } catch (FailedLoginException fle) {
          FacesMessage msg =
              new FacesMessage(FacesMessage.SEVERITY_ERROR, "Incorrect Username or Password",
                               "An incorrect Username or Password" +
                               " was specified");
          ctx.addMessage("d2:it35", msg);
      } catch (LoginException le) {
          reportUnexpectedLoginError("LoginException", le);
      }
      return null;
  }

  private void sendForward(HttpServletRequest request,
                           HttpServletResponse response, String forwardUrl) {
      FacesContext ctx = FacesContext.getCurrentInstance();
      RequestDispatcher dispatcher = request.getRequestDispatcher(forwardUrl);
      try {
          dispatcher.forward(request, response);
      } catch (ServletException se) {
          reportUnexpectedLoginError("ServletException", se);
      } catch (IOException ie) {
          reportUnexpectedLoginError("IOException", ie);
      }
      ctx.responseComplete();
  }

  private void reportUnexpectedLoginError(String errType, Exception e) {
      FacesMessage msg =
          new FacesMessage(FacesMessage.SEVERITY_ERROR, "Unexpected error during login",
                           "Unexpected error during login (" + errType +
                           "), please consult logs for detail");
      FacesContext.getCurrentInstance().addMessage("d2:it35", msg);
      e.printStackTrace();
  }

    public String logout() {
        FacesContext ctx = FacesContext.getCurrentInstance();  
        ExternalContext ectx = ctx.getExternalContext();
        String logoutUrl = "faces" + ctx.getViewRoot().getViewId();
        ((HttpServletRequest)ectx.getRequest()).getSession().invalidate();
        try {
            ectx.redirect(logoutUrl);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
