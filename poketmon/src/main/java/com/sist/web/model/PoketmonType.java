package com.sist.web.model;

import java.io.Serializable;

public class PoketmonType implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private int pokeType;
	private String pokeTypeName;
	private String pokeTypeColor;
	private String pokeEnTypeName;
	
	public PoketmonType()
	{
		pokeType = 0;
		pokeTypeName = "";
		pokeTypeColor = "";
		pokeEnTypeName = "";
	}
	
	
	
	public String getPokeEnTypeName() {
		return pokeEnTypeName;
	}



	public void setPokeEnTypeName(String pokeEnTypeName) {
		this.pokeEnTypeName = pokeEnTypeName;
	}



	public int getPokeType() {
		return pokeType;
	}

	public void setPokeType(int pokeType) {
		this.pokeType = pokeType;
	}

	public String getPokeTypeName() {
		return pokeTypeName;
	}

	public void setPokeTypeName(String pokeTypeName) {
		this.pokeTypeName = pokeTypeName;
	}

	public String getPokeTypeColor() {
		return pokeTypeColor;
	}

	public void setPokeTypeColor(String pokeTypeColor) {
		this.pokeTypeColor = pokeTypeColor;
	}
	
	@Override
	public String toString() {
	    return "PoketmonType{" +
	            "pokeType='" + pokeType + '\'' +
	            ", pokeTypeName='" + pokeTypeName + '\'' +
	            ", pokeEnTypeName='" + (pokeEnTypeName != null ? pokeEnTypeName : "N/A") + '\'' +
	            '}';
	}
}
