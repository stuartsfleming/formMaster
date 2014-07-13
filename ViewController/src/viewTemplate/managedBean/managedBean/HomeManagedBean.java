package viewTemplate.managedBean.managedBean;

import java.io.IOException;

import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.faces.event.ActionEvent;

import oracle.adf.view.rich.component.rich.RichPopup;
import oracle.adf.view.rich.component.rich.nav.RichCommandImageLink;

public class HomeManagedBean {
    
    private RichPopup popupP1;
    
    public HomeManagedBean() {
    }

    //based on the current state of the login link, 
    //log user in or out
    public void onLoginLogout(ActionEvent actionEvent) {
        RichCommandImageLink rcil = (RichCommandImageLink) actionEvent.getComponent();
        String commandLinkIcon = rcil.getIcon();
        if (commandLinkIcon.indexOf("glbl_login_msg.gif") >0){
          //login
          RichPopup.PopupHints hints = new RichPopup.PopupHints();
          popupP1.show(hints);
        }
        else{
          //logout         
          FacesContext fctx = FacesContext.getCurrentInstance();
          ExternalContext ectx = fctx.getExternalContext();
            try {
                ectx.redirect("/adfAuthentication?logout=true&end_url=/faces/main.jspx");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }        
    }

    public void setPopupP1(RichPopup popupP1) {
        this.popupP1 = popupP1;
    }

    public RichPopup getPopupP1() {
        return popupP1;
    }
}
