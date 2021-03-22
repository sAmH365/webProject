package util;



import javax.mail.Authenticator; 

import javax.mail.PasswordAuthentication;



public class Gmail extends Authenticator {

	//SMTP서버에 연결해 사용자 인증을 하기위해서 Authenticator 클래스 사용이 필요하다.

    @Override
    //Authenticator를 사용하기 위해서는 PasswordAuthenticator클래스로부터 인스턴스를 생성하고
    //getPasswordAuthentication메소드로 리턴받아야 한다.
    //PasswordAuthentication클래스는 사용자의 아이디와 패스워드를입력바아 반환하도록 재정의한다.
    protected PasswordAuthentication getPasswordAuthentication() {

        return new PasswordAuthentication("kwonsaehim","1q2w3e4r@");
        
    }

    

}
