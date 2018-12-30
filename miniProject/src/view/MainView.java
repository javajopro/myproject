package view;

import java.awt.Color;
import java.awt.Font;
import java.awt.Rectangle;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;
import javax.swing.border.EmptyBorder;

import controller.Manager;

public class MainView extends JFrame {

	private JPanel contentPane;
	private JTextField textField;
	private JPasswordField passwordField;

	
	public MainView() {
		
		new Manager();
		
		ClockMessage clockMessage = new ClockMessage();
		clockMessage.setBounds(1130,640,220,40);
		clockMessage.setOpaque(false);
		new Thread(clockMessage).start();
		
		setBounds(new Rectangle(0, 0, 1280, 720));
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		contentPane.add(clockMessage);
		
		JLabel lblNewLabel_1 = new JLabel("���̵�");
		lblNewLabel_1.setFont(new Font("����", Font.PLAIN, 15));
		lblNewLabel_1.setBounds(548, 117, 47, 30);
		contentPane.add(lblNewLabel_1);
		
		textField = new JTextField();
		textField.setBounds(613, 118, 116, 30);
		contentPane.add(textField);
		textField.setColumns(10);
		
		JLabel lblNewLabel_2 = new JLabel("���");
		lblNewLabel_2.setFont(new Font("����", Font.PLAIN, 15));
		lblNewLabel_2.setBounds(548, 173, 47, 30);
		contentPane.add(lblNewLabel_2);
		
		JLabel lblKh = new JLabel("kh ���� ������");
		lblKh.setFont(new Font("����", Font.PLAIN, 54));
		lblKh.setBounds(447, 10, 369, 102);
		contentPane.add(lblKh);
		
		JButton btnNewButton = new JButton("\uB85C\uADF8\uC778");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
			}
		});
		btnNewButton.setBounds(548, 232, 181, 54);
		contentPane.add(btnNewButton);
		
		JButton btnNewButton_1 = new JButton("id \uCC3E\uAE30");
		btnNewButton_1.setBorderPainted(false);
		btnNewButton_1.setContentAreaFilled(false);
		btnNewButton_1.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
			}
		});
		btnNewButton_1.setBounds(521, 296, 116, 23);
		contentPane.add(btnNewButton_1);
		
		JButton btnNewButton_2 = new JButton("\uD328\uC2A4\uC6CC\uB4DC \uCC3E\uAE30\r\n");
		btnNewButton_2.setContentAreaFilled(false);
		btnNewButton_2.setBorderPainted(false);
		btnNewButton_2.setBounds(626, 296, 116, 23);
		contentPane.add(btnNewButton_2);
		
		passwordField = new JPasswordField();
		passwordField.setBounds(613, 178, 116, 30);
		contentPane.add(passwordField);
		
		JButton btnNewButton_3 = new JButton("\uD68C\uC6D0\uAC00\uC785^^");
		btnNewButton_3.setBorderPainted(false);
		btnNewButton_3.setContentAreaFilled(false);
		btnNewButton_3.setBounds(582, 329, 116, 23);
		contentPane.add(btnNewButton_3);
		
		JLabel lblNewLabel = new JLabel();
		lblNewLabel.setFont(new Font("�ü�ü", Font.ITALIC, 12));
		lblNewLabel.setIcon(new ImageIcon("image/MainBackGround.png"));
		lblNewLabel.setBounds(0, 0, 1264, 681);
		
		contentPane.add(lblNewLabel);
		setVisible(true);
	}
	
	class ClockMessage extends JPanel implements Runnable{
		
		int i = Calendar.getInstance().get(Calendar.AM_PM);
		String[] amPm = {"AM", "PM"};
		SimpleDateFormat sdf = new SimpleDateFormat("hh:mm:ss");
		String time = sdf.format(new Date());
		JLabel timeLabel, ampmLabel;
		
		public ClockMessage(){
			this.setLayout(null);
			
			timeLabel = new JLabel(time);
			timeLabel.setBounds(28,0,100,30);
			timeLabel.setForeground(Color.white);
			timeLabel.setFont(new Font("���� ���",Font.BOLD,18));
			
			ampmLabel = new JLabel(amPm[i]);
			ampmLabel.setBounds(0,-13,40,60);
			ampmLabel.setForeground(Color.WHITE);
			ampmLabel.setFont(new Font("���� ���",Font.BOLD,14));
			
			add(timeLabel);
			add(ampmLabel);
		}
		
		public void run() {
			do{
				try{
					Thread.sleep(1000);
				}catch(InterruptedException e){
					e.printStackTrace();
				}
				timeLabel.setText(sdf.format(new Date()));
			}while(true);
		}
		
	}
}
