package main;

import java.util.Scanner;

import dao.MembersDao;
import dto.MembersDto;

// 비즈니스 로직(business logic)

public class MembersHandler {

	// field
	private MembersDao dao = MembersDao.getInstance();
	private Scanner sc = new Scanner(System.in);
	
	// method
	private void menu() {
		System.out.println("=====회원관리=====");
		System.out.println("0. 프로그램 종료");
		System.out.println("1. 가입");
		System.out.println("2. 탈퇴");
		System.out.println("3. 수정");
		System.out.println("==================");
	}
	public void execute() {
		while (true) {
			menu();
			System.out.println("선택(0~) >>>");
			switch (sc.nextInt()) {
			case 0 : System.out.println("프로그램을 종료합니다."); return;
			case 1 : join(); break;
			case 2 : leave(); break;
			case 3 : modify(); break;
			
			}
		}
	}
	// 가입
	public void join() {
		System.out.print("신규 아이디 >>> ");
		String mId = sc.next();
		System.out.print("사용자명 >>> ");
		String mName = sc.next();
		System.out.print("이메일 >>> ");
		String mEmail = sc.next();
		
		MembersDto dto = new MembersDto();
		dto.setmId(mId);
		dto.setmName(mName);
		dto.setmEmail(mEmail);
		//MembersDto dto2 = new MembersDto(0L, mId, mName, mEmail, null);
	
		int result = dao.insertMembers(dto);
		if (result > 0) {
			System.out.println(mId + "님이 가입되었습니다.");
		} else {  // result == 0
			System.out.println(mId + "님의 가입이 실패했습니다.");
		}
	}
	// 탈퇴
	public void leave() {
		System.out.print("탈퇴할 아이디 >>> ");
		String mId = sc.next();
		
		System.out.print("탈퇴할까요(y/n)? >>> ");
		String yn = sc.next();
		if (yn.equalsIgnoreCase("y")) {
			int result = dao.deleteMember(mId);
			if (result > 0) {
				System.out.println(mId + "님이 탈퇴되었습니다.감사합니다.");			
		} else {
			System.out.println(mId + "님이 탈퇴되지 않았습니다.");
		}
	} else {
		System.out.println("탈퇴 작업이 취소되었습니다.");
	}
	
	}
	// 수정
	public void modify() {
		System.out.print("수정할 회원의 아이디 >>> ");
		String mId = sc.next();
		System.out.print("수정할 이름 >>> ");
		String mName = sc.next();
		System.out.print("수정할 이메일 >>> ");
		String mEmail = sc.next();
		
		MembersDto dto = new MembersDto();
		dto.setmId(mId);
		dto.setmName(mName);
		dto.setmEmail(mEmail);
		
		int result = dao.updateMembers(dto);
		if (result > 0) {
			System.out.println(mId + "님의 정보가 수정되었습니다.");
		} else {
			System.out.println(mId + "님의 정보수정이 실패했습니다.");
		} 
	}
	
	
}

