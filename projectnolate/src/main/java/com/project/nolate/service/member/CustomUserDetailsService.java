package com.project.nolate.service.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.project.nolate.dao.MemberDAO;
import com.project.nolate.domain.CustomMemberSignin;
import com.project.nolate.domain.Member;


@Service
public class CustomUserDetailsService implements UserDetailsService {

	//@Autowired
	private MemberDAO memberDao;
	
	public CustomUserDetailsService() {
		// TODO Auto-generated constructor stub
	}
	
	@Autowired
	public CustomUserDetailsService(MemberDAO memberDao) {
		this.memberDao = memberDao;
	}



	@Override
	public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		
		Member member = memberDao.getMember(id);
		
		return new CustomMemberSignin(member);
		
	}

}
