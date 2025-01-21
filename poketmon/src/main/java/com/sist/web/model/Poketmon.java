package com.sist.web.model;

import java.io.Serializable;
import java.util.List;

public class Poketmon implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private int pokeId;
	private int pokeTypeFirst;
	private String pokeTypenameFirst;
	private int pokeTypeSecond;
	private String pokeTypenameSecond;
	
	private String pokeTypeColorFirst;
	private String pokeTypeColorSecond;
	
	private String pokeName;
	
	private int pokeEvo;
	private int pokeGrade;
		
	private float pokeHeight;
	private float pokeWeight;
	private String pokeImg;
	private String pokeContent;
	
	private long startNum;	
	private long endNum;	
	
	private int pokePrev;
	private int pokeNext;
	
	private List<Integer> typeList;
	
	private int startDogam;
	private int endDogam;
	private float startWeight;
	private float endWeight; 
	private float startHeight;
	private float endHeight;
	
	private int sortType;
    
    private int minIndexNum;
    private int maxIndexNum;
    private int minHeightNum;
    private int maxHeightNum;
    private int minWeightNum;
    private int maxWeightNum;
    private String[] pokeTypes;
    
    private int pokeSortValue;
    
    private String pokeSearch;
	 
	
	public Poketmon()
	{
		pokeId = 0;
		pokeTypeFirst = 0;
		pokeTypenameFirst = "";
		pokeTypenameSecond = "";
		pokeTypeSecond = 0;
		
		pokeTypeColorFirst = "";
		pokeTypeColorSecond = "";
		
		pokeName = "";
		
		pokeEvo = 0;
		pokeGrade = 0;
		
		pokeHeight = 0;
		pokeWeight = 0;
		pokeImg = "";
		pokeContent = "";
		
		startNum = 0;		
		endNum = 0;	
		
		pokePrev = 0;
		pokeNext = 0;
		
		typeList = null;
		startDogam = 0;
		endDogam = 0;
		startWeight = 0;
		endWeight = 0; 
		startHeight = 0;
		endHeight = 0;
		
		pokeSortValue = 0;
		pokeSearch = "";
		
	}
	
	
	
	
	
	
	public String getPokeSearch() {
		return pokeSearch;
	}


	public void setPokeSearch(String pokeSearch) {
		this.pokeSearch = pokeSearch;
	}



	public int getPokeSortValue() {
		return pokeSortValue;
	}

	public void setPokeSortValue(int pokeSortValue) {
		this.pokeSortValue = pokeSortValue;
	}



	public int getSortType() {
		return sortType;
	}



	public void setSortType(int sortType) {
		this.sortType = sortType;
	}



	public int getMinIndexNum() {
		return minIndexNum;
	}



	public void setMinIndexNum(int minIndexNum) {
		this.minIndexNum = minIndexNum;
	}



	public int getMaxIndexNum() {
		return maxIndexNum;
	}



	public void setMaxIndexNum(int maxIndexNum) {
		this.maxIndexNum = maxIndexNum;
	}



	public int getMinHeightNum() {
		return minHeightNum;
	}



	public void setMinHeightNum(int minHeightNum) {
		this.minHeightNum = minHeightNum;
	}



	public int getMaxHeightNum() {
		return maxHeightNum;
	}



	public void setMaxHeightNum(int maxHeightNum) {
		this.maxHeightNum = maxHeightNum;
	}



	public int getMinWeightNum() {
		return minWeightNum;
	}



	public void setMinWeightNum(int minWeightNum) {
		this.minWeightNum = minWeightNum;
	}



	public int getMaxWeightNum() {
		return maxWeightNum;
	}



	public void setMaxWeightNum(int maxWeightNum) {
		this.maxWeightNum = maxWeightNum;
	}



	public String[] getPokeTypes() {
		return pokeTypes;
	}



	public void setPokeTypes(String[] pokeTypes) {
		this.pokeTypes = pokeTypes;
	}



	public List<Integer> getTypeList() {
		return typeList;
	}



	public void setTypeList(List<Integer> typeList) {
		this.typeList = typeList;
	}



	public int getStartDogam() {
		return startDogam;
	}



	public void setStartDogam(int startDogam) {
		this.startDogam = startDogam;
	}



	public int getEndDogam() {
		return endDogam;
	}



	public void setEndDogam(int endDogam) {
		this.endDogam = endDogam;
	}



	public float getStartWeight() {
		return startWeight;
	}



	public void setStartWeight(float startWeight) {
		this.startWeight = startWeight;
	}



	public float getEndWeight() {
		return endWeight;
	}



	public void setEndWeight(float endWeight) {
		this.endWeight = endWeight;
	}



	public float getStartHeight() {
		return startHeight;
	}



	public void setStartHeight(float startHeight) {
		this.startHeight = startHeight;
	}



	public float getEndHeight() {
		return endHeight;
	}



	public void setEndHeight(float endHeight) {
		this.endHeight = endHeight;
	}



	public int getPokePrev() {
		return pokePrev;
	}



	public void setPokePrev(int pokePrev) {
		this.pokePrev = pokePrev;
	}



	public int getPokeNext() {
		return pokeNext;
	}



	public void setPokeNext(int pokeNext) {
		this.pokeNext = pokeNext;
	}



	public int getPokeGrade() {
		return pokeGrade;
	}



	public void setPokeGrade(int pokeGrade) {
		this.pokeGrade = pokeGrade;
	}



	public String getPokeTypeColorFirst() {
		return pokeTypeColorFirst;
	}



	public void setPokeTypeColorFirst(String pokeTypeColorFirst) {
		this.pokeTypeColorFirst = pokeTypeColorFirst;
	}



	public String getPokeTypeColorSecond() {
		return pokeTypeColorSecond;
	}



	public void setPokeTypeColorSecond(String pokeTypeColorSecond) {
		this.pokeTypeColorSecond = pokeTypeColorSecond;
	}



	public int getPokeTypeFirst() {
		return pokeTypeFirst;
	}



	public void setPokeTypeFirst(int pokeTypeFirst) {
		this.pokeTypeFirst = pokeTypeFirst;
	}



	public String getPokeTypenameFirst() {
		return pokeTypenameFirst;
	}



	public void setPokeTypenameFirst(String pokeTypenameFirst) {
		this.pokeTypenameFirst = pokeTypenameFirst;
	}



	public int getPokeTypeSecond() {
		return pokeTypeSecond;
	}



	public void setPokeTypeSecond(int pokeTypeSecond) {
		this.pokeTypeSecond = pokeTypeSecond;
	}



	public String getPokeTypenameSecond() {
		return pokeTypenameSecond;
	}



	public void setPokeTypenameSecond(String pokeTypenameSecond) {
		this.pokeTypenameSecond = pokeTypenameSecond;
	}



	public long getStartNum() {
		return startNum;
	}



	public void setStartNum(long startNum) {
		this.startNum = startNum;
	}



	public long getEndNum() {
		return endNum;
	}



	public void setEndNum(long endNum) {
		this.endNum = endNum;
	}



	public int getPokeId() {
		return pokeId;
	}

	public void setPokeId(int pokeId) {
		this.pokeId = pokeId;
	}


	public String getPokeName() {
		return pokeName;
	}

	public void setPokeName(String pokeName) {
		this.pokeName = pokeName;
	}

	public int getPokeEvo() {
		return pokeEvo;
	}

	public void setPokeEvo(int pokeEvo) {
		this.pokeEvo = pokeEvo;
	}

	public float getPokeHeight() {
		return pokeHeight;
	}

	public void setPokeHeight(float pokeHeight) {
		this.pokeHeight = pokeHeight;
	}

	public float getPokeWeight() {
		return pokeWeight;
	}

	public void setPokeWeight(float pokeWeight) {
		this.pokeWeight = pokeWeight;
	}

	public String getPokeImg() {
		return pokeImg;
	}

	public void setPokeImg(String pokeImg) {
		this.pokeImg = pokeImg;
	}

	public String getPokeContent() {
		return pokeContent;
	}

	public void setPokeContent(String pokeContent) {
		this.pokeContent = pokeContent;
	}
	
	
	
}


