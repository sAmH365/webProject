package store;

public class StoreDTO {
	
	private String title;
	private String address;
	private String area;
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	@Override
	public String toString() {
		return "StoreDTO [title=" + title + ", address=" + address + ", area=" + area + "]";
	}
	
	
}
