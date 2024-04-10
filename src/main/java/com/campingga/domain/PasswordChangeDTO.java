package com.campingga.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PasswordChangeDTO {
	private String mem_id;
	private String oldPassword;
	private String newPassword;
}
