package util;



import javax.mail.Authenticator; 

import javax.mail.PasswordAuthentication;



public class Gmail extends Authenticator {

	//SMTP������ ������ ����� ������ �ϱ����ؼ� Authenticator Ŭ���� ����� �ʿ��ϴ�.

    @Override
    //Authenticator�� ����ϱ� ���ؼ��� PasswordAuthenticatorŬ�����κ��� �ν��Ͻ��� �����ϰ�
    //getPasswordAuthentication�޼ҵ�� ���Ϲ޾ƾ� �Ѵ�.
    //PasswordAuthenticationŬ������ ������� ���̵�� �н����带�Է¹پ� ��ȯ�ϵ��� �������Ѵ�.
    protected PasswordAuthentication getPasswordAuthentication() {

        return new PasswordAuthentication("kwonsaehim","1q2w3e4r@");
        
    }

    

}
