// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:udemy_flutter/models/shop_app/search_products_model_entity.dart';
import 'package:udemy_flutter/generated/json/search_products_model_entity_helper.dart';
import 'package:udemy_flutter/models/shop_app/favorite_model_entity.dart';
import 'package:udemy_flutter/generated/json/favorite_model_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
		switch (type) {
			case SearchProductsModelEntity:
				return searchProductsModelEntityFromJson(data as SearchProductsModelEntity, json) as T;
			case SearchProductsModelData:
				return searchProductsModelDataFromJson(data as SearchProductsModelData, json) as T;
			case ProductData:
				return ProductDataFromJson(data as ProductData, json) as T;
			case FavoriteModelEntity:
				return favoriteModelEntityFromJson(data as FavoriteModelEntity, json) as T;
			case FavoriteModelData:
				return favoriteModelDataFromJson(data as FavoriteModelData, json) as T;
			case FavoriteModelDataData:
				return favoriteModelDataDataFromJson(data as FavoriteModelDataData, json) as T;
			case FavoriteModelDataDataProduct:
				return favoriteModelDataDataProductFromJson(data as FavoriteModelDataDataProduct, json) as T;    }
		return data as T;
	}

  static _getToJson<T>(Type type, data) {
		switch (type) {
			case SearchProductsModelEntity:
				return searchProductsModelEntityToJson(data as SearchProductsModelEntity);
			case SearchProductsModelData:
				return searchProductsModelDataToJson(data as SearchProductsModelData);
			case ProductData:
				return ProductDataToJson(data as ProductData);
			case FavoriteModelEntity:
				return favoriteModelEntityToJson(data as FavoriteModelEntity);
			case FavoriteModelData:
				return favoriteModelDataToJson(data as FavoriteModelData);
			case FavoriteModelDataData:
				return favoriteModelDataDataToJson(data as FavoriteModelDataData);
			case FavoriteModelDataDataProduct:
				return favoriteModelDataDataProductToJson(data as FavoriteModelDataDataProduct);
			}
			return data as T;
		}
  //Go back to a single instance by type
	static _fromJsonSingle<M>( json) {
		String type = M.toString();
		if(type == (SearchProductsModelEntity).toString()){
			return SearchProductsModelEntity().fromJson(json);
		}
		if(type == (SearchProductsModelData).toString()){
			return SearchProductsModelData().fromJson(json);
		}
		if(type == (ProductData).toString()){
			return ProductData().fromJson(json);
		}
		if(type == (FavoriteModelEntity).toString()){
			return FavoriteModelEntity().fromJson(json);
		}
		if(type == (FavoriteModelData).toString()){
			return FavoriteModelData().fromJson(json);
		}
		if(type == (FavoriteModelDataData).toString()){
			return FavoriteModelDataData().fromJson(json);
		}
		if(type == (FavoriteModelDataDataProduct).toString()){
			return FavoriteModelDataDataProduct().fromJson(json);
		}

		return null;
	}

  //list is returned by type
	static M _getListChildType<M>(List data) {
		if(<SearchProductsModelEntity>[] is M){
			return data.map<SearchProductsModelEntity>((e) => SearchProductsModelEntity().fromJson(e)).toList() as M;
		}
		if(<SearchProductsModelData>[] is M){
			return data.map<SearchProductsModelData>((e) => SearchProductsModelData().fromJson(e)).toList() as M;
		}
		if(<ProductData>[] is M){
			return data.map<ProductData>((e) => ProductData().fromJson(e)).toList() as M;
		}
		if(<FavoriteModelEntity>[] is M){
			return data.map<FavoriteModelEntity>((e) => FavoriteModelEntity().fromJson(e)).toList() as M;
		}
		if(<FavoriteModelData>[] is M){
			return data.map<FavoriteModelData>((e) => FavoriteModelData().fromJson(e)).toList() as M;
		}
		if(<FavoriteModelDataData>[] is M){
			return data.map<FavoriteModelDataData>((e) => FavoriteModelDataData().fromJson(e)).toList() as M;
		}
		if(<FavoriteModelDataDataProduct>[] is M){
			return data.map<FavoriteModelDataDataProduct>((e) => FavoriteModelDataDataProduct().fromJson(e)).toList() as M;
		}

		throw Exception("not found");
	}

  static M fromJsonAsT<M>(json) {
		if (json is List) {
			return _getListChildType<M>(json);
		} else {
			return _fromJsonSingle<M>(json) as M;
		}
	}
}