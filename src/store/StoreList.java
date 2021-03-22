package store;

import java.io.IOException;  
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.NamingException;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

import util.Database;

public class StoreList {
	private static String URL = "https://www.starbucks.co.kr/store/store_map.do?disp=locale";

	public static void main(String[] args) throws IOException, InterruptedException, SQLException, NamingException, ClassNotFoundException {
		ArrayList<StoreDTO> storeList = new ArrayList<StoreDTO>();
		StoreDTO storeDto = new StoreDTO();
		WebElement webElement = null;
		
		//Connection
		String user = "scott"; 
        String pw = "tiger";
        String url = "jdbc:oracle:thin:@localhost:1521:xe";
        
        Class.forName("oracle.jdbc.driver.OracleDriver");        
        Connection conn = DriverManager.getConnection(url, user, pw);
		
		String sql = "insert into storeList values(?, ?, ?)";
		PreparedStatement pstmt = null;
				
		// System.out.println(System.getProperty("user.dir"));
		Path path = Paths.get(System.getProperty("user.dir"), "util\\chromedriver.exe"); // 크롬드라이버 경로얻기

		/* WebDriver 경로 설정 */
		System.setProperty("webdriver.chrome.driver", path.toString());

		/* WebDriver 옵션 설정 */
		ChromeOptions options = new ChromeOptions();
		options.addArguments("--start-maximized");// 전체화면으로 실행
		options.addArguments("--disable-popup-blocking");// 팝업무시
		options.addArguments("--disable-default-apps");// 기본앱 사용 안함

		/* WebDriver 객체 생성 */
		ChromeDriver driver = new ChromeDriver(options);

		// 스타벅스 매장열기
		driver.get(URL);
		Thread.sleep(1000);

		String area[] = { "서울", "경기", "광주", "대구", "대전", "부산", "울산", "인천", "강원", "경남", "경북", "전남", "전북", "충남", "충북",
				"제주", "세종" };

		for (int i = 0; i < area.length; i++) {
			// 지역검색 연결
			WebElement loca = driver.findElementByClassName("loca_search");
			loca.click();
			Thread.sleep(500);
			webElement = driver.findElementByLinkText(area[i]);
			webElement.click();
			Thread.sleep(500);

			if (area[i].equals("세종")) {
				String source = driver.getPageSource(); // html 형식으로 얻어줌

				Document doc = Jsoup.parse(source);

				Elements elements = doc.select(".quickSearchResultBoxSidoGugun li");

				int idx = 0;//substring 인덱스번호
				for (Element element : elements) {
					String title = element.select("strong").text();
					String addr = element.select("p").text();
					idx = addr.indexOf("1522-3232");
					String address = addr.substring(0, idx);

//					System.out.println(title+"    "+address);
					storeDto.setAddress(address);
					storeDto.setTitle(title);
					storeDto.setArea(area[i]);
					
					storeList.add(storeDto);
					//System.out.println(storeList.get(listIdx++).toString());
					try {
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, storeDto.getTitle());
						pstmt.setString(2, storeDto.getAddress());
						pstmt.setString(3, storeDto.getArea());
						pstmt.executeUpdate();
						pstmt.close();
					}catch(Exception e) {
						e.printStackTrace();
					}
				}
			} else {
				webElement = driver.findElementByLinkText("전체");
				webElement.click();
				Thread.sleep(1000);

				String source = driver.getPageSource(); // html 형식으로 얻어줌

				/*-----------------------------Jsoup이용----------------------------------------*/

				Document doc = Jsoup.parse(source);

				Elements elements = doc.select(".quickSearchResultBoxSidoGugun li");
				//int listIdx =0;
				int idx = 0;//substring 인덱스번호
				for (Element element : elements) {
					String title = element.select("strong").text();
					String addr = element.select("p").text();
					idx = addr.indexOf("1522-3232");
					String address = addr.substring(0, idx);

//					System.out.println(title+"    "+address);
					storeDto.setAddress(address);
					storeDto.setTitle(title);
					storeDto.setArea(area[i]);
					
					storeList.add(storeDto);
					//System.out.println(storeList.get(listIdx++).toString());
					
					try {
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, storeDto.getTitle());
						pstmt.setString(2, storeDto.getAddress());
						pstmt.setString(3, storeDto.getArea());
						pstmt.executeUpdate();
						pstmt.close();
					}catch(Exception e) {
						e.printStackTrace();
					}
					
				}
			}
		} // for end
		
		Database.closeConnection();
		
	}

}
