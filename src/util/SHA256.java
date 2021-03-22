package util;



import java.security.MessageDigest;

public class SHA256 {
	public static String getSHA256(String input) {
		StringBuffer result = new StringBuffer();
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");//sha-256�޽��� ��������Ʈ
			byte[] salt = "Hello! This is Salt.".getBytes();
			digest.reset();
			digest.update(salt); //������ ����Ʈ �����͸� ����ؼ� ��������Ʈ ����
			byte[] chars = digest.digest(input.getBytes("UTF-8")); //����Ʈ�迭�� �ؽ��� ��ȯ, �е� ���� ���� ó���� ���� �ؽ� ����� �Ϸ�.
			for(int i = 0; i < chars.length; i++) {
				String hex = Integer.toHexString(0xff & chars[i]);
				if(hex.length() == 1) result.append('0');
				result.append(hex);
			}//Integer.toString(((byteData & 0xff)+0x100, 16).substring(1); �� ���� ǥ�� 
			 //(byte&0xff)=>�ʱ⹮�ڱ״�ιٲ��ִ� ����, +0x100=> 16������ ���� ������ 3�ڸ����� ������ִ� ����, .substring(1)=> ���� ���� ���ʿ���1 �������
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result.toString();
	}
}
