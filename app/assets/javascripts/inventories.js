
document.addEventListener("turbolinks:load", function() {

	function add_item_to_cart(target_elem) {
		item = $(target_elem).closest('.grid-item')[0].dataset;
		quantity_elem = $(target_elem).parent().parent().find('.avail-quan');
		quantity = $(target_elem).next().val();

		if (parseInt(quantity) > parseInt(item.maxquantity)) {
			$(target_elem).next().addClass('error-field');
		  $(target_elem).next().val('');
		  return false
		}

		$.ajax({
			type: 'get',
			contentType: "application/json; charset=utf-8",
     	url: "/orders/add_to_cart",
      data : {'item_name': item.itemName, 'quantity': quantity},
      dataType: "json",
      success: function (result) {
      	quantity_elem[0].textContent = result["item"]["remaining_quantity"];
	      window.alert("Added to cart!");

	    },
      error: function (){
        window.alert("something wrong!");
      }
		});
	}

	function remove_item_from_cart(target_elem) {
      item = $(target_elem).closest('.grid-item')[0].dataset;
			quantity_elem = $(target_elem).parent().parent().find('.avail-quan');
			quantity = quantity_elem[1].textContent;

			$.ajax({
			type: 'get',
			contentType: "application/json; charset=utf-8",
     	url: "/orders/remove_from_cart",
      data : {'item_name': item.itemName, 'quantity': quantity},
      dataType: "json",
      success: function (result) {
      	$('.remove-from-cart').parent().addClass('hide');
	      window.alert("Removed cart!");
	    },
      error: function (){
        window.alert("something wrong!");
      }
		});
	}
	
	$('.add-to-cart').on('click',function(){
	  add_item_to_cart(this);		
	})

	$('.remove-from-cart').on('click', function(){
		remove_item_from_cart(this);
	})

	// $('.quantity').on('click', function(){
	// 	add_item_to_cart(this;)
	// })
})
