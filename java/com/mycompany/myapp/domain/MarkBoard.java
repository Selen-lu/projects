package com.mycompany.myapp.domain;

public class MarkBoard {


	//북마크한 장소의 정보 vo
	private int no; //  북마크 넘버  , DB ->시퀀스처리함 
	private String name; // 북마크한 장소 이름  ex) 서울특별시 강남구 역삼동
	private String latitude; //위도
	private String longitude; //경도
	private String latticeX; //격자X
	private String latticeY;//격자 Y
	private String nickname; //사용자가 북마크한 장소의 별칭 , DB- NOTNULL 처리 안 했음
	

	public MarkBoard() {}
	
	
	public MarkBoard(int no,String name,String latitude,String longitude,String latticeX,String latticeY,String nickname) {
		
		this.no = no;
		this.name =name;
		this.latitude =latitude;
		this.longitude =longitude;
		this.latticeX=latticeX;
		this.latticeY =latticeY;
		this.nickname=nickname;

	}

	public int getNo() {
		return no;
	}


	public void setNo(int no) {
		this.no = no;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getLatitude() {
		return latitude;
	}


	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}


	public String getLongitude() {
		return longitude;
	}


	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}


	public String getLatticeX() {
		return latticeX;
	}


	public void setLatticeX(String latticeX) {
		this.latticeX = latticeX;
	}


	public String getLatticeY() {
		return latticeY;
	}


	public void setLatticeY(String latticeY) {
		this.latticeY = latticeY;
	}


	public String getNickname() {
		return nickname;
	}


	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	
}
