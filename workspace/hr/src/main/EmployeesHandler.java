package main;

import java.util.List;
import java.util.Scanner;

import dao.EmployeesDao;
import dto.EmployeesDto;

public class EmployeesHandler {

	// field
	private EmployeesDao dao = EmployeesDao.getInstatnce();
	Scanner sc = new Scanner(System.in);
	
	// method
	public void menu() {
		System.out.println("=====회원조회=====");
		System.out.println("0. 프로그램 종료");
		System.out.println("1. 부서 조회");
		System.out.println("==================");
	}
	public void execute() {
		while (true) {
			menu();
			System.out.println("선택 >>> ");
			switch (sc.nextInt()) {
			case 0 : System.out.println("회원조회 서비스를 종료합니다."); sc.close(); return;
			case 1 : inquriyByDepartmentId(); break;
			}
		}
	}
	// 부서조회
	public void inquriyByDepartmentId() {
		System.out.println("부서(10~110) 입력 >>> ");
		int departmentId = sc.nextInt();
		List<EmployeesDto> list = dao.selectEmployeesByDepartmentId(departmentId);
		System.out.println("총 사원 수: " + list.size());
		for (EmployeesDto dto : list) {
			System.out.println(dto);
		}
	}
}
