package vo;

public class Book {
	private String bookNum;
	private String category;
	private String title;
	private String author;
	private String borrowDate;
	private String returnDate;
	private int extendCount;

	public Book() {
		
	}
	
	public Book(String bookNum, String category, String title, String author, String borrowDate, String returnDate,
			int extendCount) {
		this.bookNum = bookNum;
		this.category = category;
		this.title = title;
		this.author = author;
		this.borrowDate = borrowDate;
		this.returnDate = returnDate;
		this.extendCount = extendCount;
	}
	public String getBookNum() {
		return bookNum;
	}
	public void setBookNum(String bookNum) {
		this.bookNum = bookNum;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getBorrowDate() {
		return borrowDate;
	}
	public void setBorrowDate(String borrowDate) {
		this.borrowDate = borrowDate;
	}
	public String getReturnDate() {
		return returnDate;
	}
	public void setReturnDate(String returnDate) {
		this.returnDate = returnDate;
	}
	public int getExtendCount() {
		return extendCount;
	}
	public void setExtendCount(int extendCount) {
		this.extendCount = extendCount;
	}
	
	
	@Override
	public String toString() {
		return "Book [bookNum=" + bookNum + ", category=" + category + ", title=" + title + ", author=" + author
				+ ", borrowDate=" + borrowDate + ", returnDate=" + returnDate + ", extendCount=" + extendCount + "]";
	}
}
