class GetAllProductResponse {
  final ProductData data;


  GetAllProductResponse({
    required this.data,

  });

  factory GetAllProductResponse.fromJson(Map<String, dynamic> json) {
    return GetAllProductResponse(
      data: ProductData.fromJson(json['data']),

    );
  }
}

class ProductData {
  final int currentPage;
  final List<ProductListItem> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<ProductPageLink> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;

  ProductData({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      currentPage: json['current_page'],
      data: List<ProductListItem>.from(
        (json['data'] as List<dynamic>).map(
              (item) => ProductListItem.fromJson(item),
        ),
      ),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: List<ProductPageLink>.from(
        (json['links'] as List<dynamic>).map(
              (item) => ProductPageLink.fromJson(item),
        ),
      ),
      nextPageUrl: json['next_page_url'] ?? '',
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'] ?? '',
      to: json['to'],
      total: json['total'],
    );
  }
}

class ProductPageLink {
  final String? url;
  final String label;
  final bool active;

  ProductPageLink({
    required this.url,
    required this.label,
    required this.active,
  });

  factory ProductPageLink.fromJson(Map<String, dynamic> json) {
    return ProductPageLink(
      url: json['url'] != null ? json['url'] : '',
      label: json['label'],
      active: json['active'],
    );
  }
}

class ProductListItem {
  final int id;
  final String name;
  final String slug;
  final String shortDescription;
  final String description;
  final String regularPrice;
  final String salePrice;
  final String buyingPrice;
  final String sku;
  final String stockStatus;
  final int feature;
  final int quantity;
  final String? image;
  final int categoryId;
  final String createdAt;
  final String updatedAt;
  final dynamic barcode;
  final int sizeId;
  final String? url;

  ProductListItem({
    required this.id,
    required this.name,
    required this.slug,
    required this.shortDescription,
    required this.description,
    required this.regularPrice,
    required this.salePrice,
    required this.buyingPrice,
    required this.sku,
    required this.stockStatus,
    required this.feature,
    required this.quantity,
    required this.image,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.sizeId,
    required this.url,
  });

  factory ProductListItem.fromJson(Map<String, dynamic> json) {
    return ProductListItem(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      shortDescription: json['short_description'],
      description: json['description'],
      regularPrice: json['regular_price'],
      salePrice: json['sale_price'],
      buyingPrice: json['buying_price'],
      sku: json['SKU'],
      stockStatus: json['stock_status'],
      feature: json['feature'],
      quantity: json['quantity'],
      image: json['image'],
      categoryId: json['category_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      barcode: json['barcode'],
      sizeId: json['size_id'],
      url: json['url'],
    );
  }
}
