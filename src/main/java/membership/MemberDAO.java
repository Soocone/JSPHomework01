package membership;

import common.JDBConnect;
/*
 DAO(Data Access Object): 실제 데이터베이스에 접근하여
 	여러가지 CRUD 작업을 하기 위한 객체.
 */
//DB 연결을 위한 클래스를 상속한다. 
public class MemberDAO extends JDBConnect
{
	//인자가 4개인 부모의 생성자를 호출하여 연결한다.
	public MemberDAO(String drv, String url, String id, String pw) {
		super(drv, url, id, pw);
	}
	
	/*
	 사용자가 입력한 아이디, 패스워드를 통해 회원테이블을 확인한 후
	 존재하는 정보인 경우 DTO 객체에 그 정보를 담아 반환한다.
	 */
	public MemberDTO getMemberDTO(String uid, String upass) {
		
		MemberDTO dto = new MemberDTO();
		
		//회원로그인을 위한 쿼리문 작성
		String query = "SELECT * FROM member WHERE id=? AND pass=?";
		
		try {
			psmt = con.prepareStatement(query);
			//쿼리문에 사용자가 입력한 아이디, 패스워드를 설정
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			//쿼리 실행
			rs = psmt.executeQuery();
			
			//회원정보가 존재한다면 DTO객체에 회원정보를 저장한다.
			if(rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString(3));
				dto.setRegidate(rs.getString(4));
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	
	//아이디/비밀번호 찾기
	public MemberDTO findMemDTO(String uname, String uid) {
		
		MemberDTO dto = new MemberDTO();
		
		//회원조회를 위한 쿼리문 작성
		String query = "SELECT * FROM member WHERE name=? ";
		
		//이름을 통해 아이디찾기
		if(uid == ""){
			try {
				psmt = con.prepareStatement(query);
				//쿼리문에 사용자가 입력한 이름을 설정
				psmt.setString(1, uname);
				//쿼리 실행
				rs = psmt.executeQuery();
				
				//회원이름이 존재한다면 DTO객체에 회원ID를 저장한다.
				if(rs.next()) {
					dto.setId(rs.getString("id"));
				}
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//이름과 아이디를 통해 비밀번호 찾기
		else {
			try {
				query += " AND id=? ";
				psmt = con.prepareStatement(query);
				//쿼리문에 사용자가 입력한 이름, 아이디를 설정
				psmt.setString(1, uname);
				psmt.setString(2, uid);
				//쿼리 실행
				rs = psmt.executeQuery();
				
				//회원정보가 존재한다면 DTO객체에 회원 PW를 저장한다.
				if(rs.next()) {
					dto.setPass(rs.getString("pass"));
				}
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		return dto;
	}
	
	
	//아이디 찾기
	/*
	 * public MemberDTO findIdTO(String uname) {
	 * 
	 * MemberDTO dto = new MemberDTO();
	 * 
	 * //회원로그인을 위한 쿼리문 작성 String query = "SELECT * FROM member WHERE name=?";
	 * 
	 * try { psmt = con.prepareStatement(query); //쿼리문에 사용자가 입력한 아이디, 패스워드를 설정
	 * psmt.setString(1, uname); //쿼리 실행 rs = psmt.executeQuery();
	 * 
	 * //회원정보가 존재한다면 DTO객체에 회원정보를 저장한다. if(rs.next()) {
	 * dto.setId(rs.getString("id")); } } catch (Exception e) { e.printStackTrace();
	 * }
	 * 
	 * return dto; }
	 */
}
