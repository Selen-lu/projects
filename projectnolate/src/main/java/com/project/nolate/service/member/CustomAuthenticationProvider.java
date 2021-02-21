package com.project.nolate.service.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.project.nolate.domain.CustomMemberSignin;

@Service
public class CustomAuthenticationProvider implements AuthenticationProvider {

	
	//@Autowired
	private UserDetailsService signInService;
	
	//@Autowired
	private BCryptPasswordEncoder passdecoder;
	
	
	public CustomAuthenticationProvider() {
		// TODO Auto-generated constructor stub
	}
	
	@Autowired
	public CustomAuthenticationProvider(UserDetailsService signInService, BCryptPasswordEncoder passdecoder) {
		this.signInService = signInService;
		this.passdecoder = passdecoder;
	}



	public void setSignInService(UserDetailsService signInService) {
		this.signInService = signInService; 
	}
	
	
	
	public void setPassdecoder(BCryptPasswordEncoder passdecoder) {
		this.passdecoder = passdecoder;
	}


	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		// TODO Auto-generated method stub
		String id = (String)authentication.getCredentials();
		String pass = (String)authentication.getPrincipal();
		
		CustomMemberSignin user = (CustomMemberSignin) signInService.loadUserByUsername(id);
		
		if(!passdecoder.matches(pass, user.getPassword())) {
			throw new BadCredentialsException(id);
		}
		
		return new UsernamePasswordAuthenticationToken(id, pass, user.getAuthorities());
	}

	@Override
	public boolean supports(Class<?> arg0) {
		// TODO Auto-generated method stub
		return true;
	}

}
