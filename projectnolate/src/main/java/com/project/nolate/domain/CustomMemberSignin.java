package com.project.nolate.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;


public class CustomMemberSignin extends User {

	private Member member;
	
	public CustomMemberSignin(String username, String password, 
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password,  authorities);
		// TODO Auto-generated constructor stub
	}
	
	public CustomMemberSignin(Member vo) {
		super(vo.getId(), vo.getPass(), true, true, true, true,
				vo.getAuthList().stream().map(auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList())
				);
		
		
		this.member = vo;
	}
	
	
}
