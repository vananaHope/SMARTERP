package com.web.erp.vo;

public class PrmSch {
	// 1. 검색목록
	private String schType; // 검색타입
	private String schWord; // 검색어
	
	// 2. 페이징처리 1단계
	private int count;// 전체 데이터 건수
	private int pageSize; // 한페이지에 보여줄 데이터 건수
	private int pageCount;// 총페이지수 count/pageSize
	private int curPage;// 클릭한 현재 페이지 번호
	private int start; // 현재 페이지 시작번호
	private int end;	// 현재 페이지 마지막번호
	
	// 3. 페이징블럭처리 2단계
	private int blockSize; // 한번에 보여줄 block의 크기
	private int startBlock;	// block시작번호
	private int endBlock; // block마지막번호
	
	public PrmSch() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PrmSch(String schType, String schWord, int count, int pageSize, int pageCount, int curPage, int start,
			int end, int blockSize, int startBlock, int endBlock) {
		super();
		this.schType = schType;
		this.schWord = schWord;
		this.count = count;
		this.pageSize = pageSize;
		this.pageCount = pageCount;
		this.curPage = curPage;
		this.start = start;
		this.end = end;
		this.blockSize = blockSize;
		this.startBlock = startBlock;
		this.endBlock = endBlock;
	}

	public String getSchType() {
		return schType;
	}

	public void setSchType(String schType) {
		this.schType = schType;
	}

	public String getSchWord() {
		return schWord;
	}

	public void setSchWord(String schWord) {
		this.schWord = schWord;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public int getBlockSize() {
		return blockSize;
	}

	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}

	public int getStartBlock() {
		return startBlock;
	}

	public void setStartBlock(int startBlock) {
		this.startBlock = startBlock;
	}

	public int getEndBlock() {
		return endBlock;
	}

	public void setEndBlock(int endBlock) {
		this.endBlock = endBlock;
	}



	
	
}
