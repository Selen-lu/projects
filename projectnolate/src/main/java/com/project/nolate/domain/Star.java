package com.project.nolate.domain;

public class Star {

	String title, content, item;
	
	public Star() {}
	public Star(String title, String content, String item) {
		this.title=title;
		this.content=content;
		this.item=item;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	
}
