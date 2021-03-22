package util;



import java.security.MessageDigest;

public class SHA256 {
	public static String getSHA256(String input) {
		StringBuffer result = new StringBuffer();
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");//sha-256메시지 다이제스트
			byte[] salt = "Hello! This is Salt.".getBytes();
			digest.reset();
			digest.update(salt); //지정된 바이트 데이터를 사용해서 다이제스트 갱신
			byte[] chars = digest.digest(input.getBytes("UTF-8")); //바이트배열로 해쉬를 반환, 패딩 등의 최종 처리를 행해 해시 계산을 완료.
			for(int i = 0; i < chars.length; i++) {
				String hex = Integer.toHexString(0xff & chars[i]);
				if(hex.length() == 1) result.append('0');
				result.append(hex);
			}//Integer.toString(((byteData & 0xff)+0x100, 16).substring(1); 랑 같은 표현 
			 //(byte&0xff)=>초기문자그대로바꿔주는 연산, +0x100=> 16이하의 수도 강제로 3자리수로 만들어주는 연산, .substring(1)=> 제일 앞의 불필요한1 떼어놓음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result.toString();
	}
}
