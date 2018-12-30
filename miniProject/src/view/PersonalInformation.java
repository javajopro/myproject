package view;

import java.awt.Dimension;
import java.awt.Font;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.border.EmptyBorder;

import vo.User;

public class PersonalInformation extends JFrame {
	
	public static void main(String[] args) {
		new PersonalInformation();
	}

	private JPanel panelPIbgr;
	private JTextField txtFldName;
	private JTextField txtFldId;
	private JTextField txtFldBirthday;
	private JTextField txtFldSuspend;
	private JTextField txtFldBorrowCurrentCount;
	private JTextField txtFldBorrowCount;
	private JTextField txtFldOverdueCount;

	public PersonalInformation() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(0, 0, 1280, 720);
		panelPIbgr = new JPanel();
		panelPIbgr.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(panelPIbgr);
		panelPIbgr.setLayout(null);
		
		JLabel label = new JLabel("회원 정보 조회");
		label.setFont(new Font("Lucida Grande", Font.PLAIN, 30));
		label.setBounds(553, 61, 174, 48);
		panelPIbgr.add(label);
		
		JLabel userImg = new JLabel();
		userImg.setIcon(new ImageIcon("image/testUser.jpg"));
		userImg.setBounds(352, 182, 200, 250);
		panelPIbgr.add(userImg);
		
		JLabel lblName = new JLabel("이름");
		lblName.setBounds(609, 200, 61, 16);
		panelPIbgr.add(lblName);
		
		JLabel lblId = new JLabel("ID");
		lblId.setBounds(609, 243, 61, 16);
		panelPIbgr.add(lblId);
		
		JLabel lblBirthday = new JLabel("생년월일");
		lblBirthday.setBounds(609, 293, 61, 16);
		panelPIbgr.add(lblBirthday);
		
		JLabel lblSuspend = new JLabel("대출가능상태");
		lblSuspend.setBounds(609, 344, 66, 16);
		panelPIbgr.add(lblSuspend);
		
		txtFldName = new JTextField();
		txtFldName.setEditable(false);
		txtFldName.setText("이름");
		txtFldName.setBounds(693, 195, 130, 26);
		panelPIbgr.add(txtFldName);
		txtFldName.setColumns(10);
		
		txtFldId = new JTextField();
		txtFldId.setEditable(false);
		txtFldId.setText("ID");
		txtFldId.setBounds(693, 238, 130, 26);
		panelPIbgr.add(txtFldId);
		txtFldId.setColumns(10);
		
		txtFldBirthday = new JTextField();
		txtFldBirthday.setEditable(false);
		txtFldBirthday.setText("생년월일");
		txtFldBirthday.setBounds(693, 288, 130, 26);
		panelPIbgr.add(txtFldBirthday);
		txtFldBirthday.setColumns(10);
		
		txtFldSuspend = new JTextField();
		txtFldSuspend.setEditable(false);
		txtFldSuspend.setText("대출가능상태");
		txtFldSuspend.setBounds(693, 339, 130, 26);
		panelPIbgr.add(txtFldSuspend);
		txtFldSuspend.setColumns(10);
		
		JButton btnInfoRevise = new JButton("정보 수정");
		btnInfoRevise.setBounds(593, 394, 117, 29);
		panelPIbgr.add(btnInfoRevise);
		
		JButton btnPwRevise = new JButton("비밀번호 수정");
		btnPwRevise.setBounds(719, 394, 117, 29);
		panelPIbgr.add(btnPwRevise);
		
		JLabel lblBorrowCurrentCount = new JLabel("현재 대출 권수");
		lblBorrowCurrentCount.setBounds(480, 486, 79, 16);
		panelPIbgr.add(lblBorrowCurrentCount);
		
		JLabel lblBorrowCount = new JLabel("총 대출 권수");
		lblBorrowCount.setBounds(613, 486, 66, 16);
		panelPIbgr.add(lblBorrowCount);
		
		JLabel lblOverdueCount = new JLabel("연체 횟수");
		lblOverdueCount.setBounds(747, 486, 48, 16);
		panelPIbgr.add(lblOverdueCount);
		
		txtFldBorrowCurrentCount = new JTextField();
		txtFldBorrowCurrentCount.setEditable(false);
		txtFldBorrowCurrentCount.setText("현재 대출 권수");
		txtFldBorrowCurrentCount.setBounds(474, 514, 91, 26);
		panelPIbgr.add(txtFldBorrowCurrentCount);
		txtFldBorrowCurrentCount.setColumns(10);
		
		txtFldBorrowCount = new JTextField();
		txtFldBorrowCount.setEditable(false);
		txtFldBorrowCount.setText("총 대출 권수");
		txtFldBorrowCount.setBounds(610, 514, 73, 26);
		panelPIbgr.add(txtFldBorrowCount);
		txtFldBorrowCount.setColumns(10);
		
		txtFldOverdueCount = new JTextField();
		txtFldOverdueCount.setEditable(false);
		txtFldOverdueCount.setText("연체 횟수");
		txtFldOverdueCount.setBounds(741, 514, 61, 26);
		panelPIbgr.add(txtFldOverdueCount);
		txtFldOverdueCount.setColumns(10);
		
		
		
		
		// test용 회원
		User testUser = new User("1", "홍길동", "hong", "1234", "180931", 3, 10, 0, false);		
		txtFldName.setText(testUser.getName());
		txtFldId.setText(testUser.getId());
		txtFldBirthday.setText(testUser.getBirthday());
		if(testUser.isSuspend()) {
			txtFldSuspend.setText("불가능");
		}
		else {
			txtFldSuspend.setText("가능");
		}
		txtFldBorrowCurrentCount.setText(Integer.toString(testUser.getBorrowCurrentCount()));
		txtFldBorrowCount.setText(Integer.toString(testUser.getBorrowCount()));
		txtFldOverdueCount.setText(Integer.toString(testUser.getOverdueCount()));
		
		
		
		
		
		
		
		JLabel bgrImg = new JLabel();
		bgrImg.setIcon(new ImageIcon("image/PersonalInformation.jpg"));
		bgrImg.setBounds(0, 0, 1280, 720);
		panelPIbgr.add(bgrImg);
		
		setVisible(true);
	}
}
