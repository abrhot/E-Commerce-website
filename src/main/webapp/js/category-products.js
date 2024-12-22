// Quantity control functions
function decreaseQty(productId) {
    const input = document.getElementById(`qty-${productId}`);
    if(input.value > 1) {
        input.value = parseInt(input.value) - 1;
    }
}

function increaseQty(productId) {
    const input = document.getElementById(`qty-${productId}`);
    if(input.value < 10) {
        input.value = parseInt(input.value) + 1;
    }
}

// Add to cart function
function addToCart(productId) {
    const qty = document.getElementById(`qty-${productId}`).value;

    // Make AJAX call to add item to cart
    fetch('/add-to-cart', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            productId: productId,
            quantity: qty
        })
    })
    .then(response => response.json())
    .then(data => {
        if(data.success) {
            // Show success message
            showNotification('Product added to cart successfully!', 'success');
            // Update cart count if necessary
            updateCartCount(data.cartCount);
        } else {
            showNotification('Failed to add product to cart.', 'error');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        showNotification('An error occurred.', 'error');
    });
}

// Helper function to show notifications
function showNotification(message, type) {
    // Implement your notification system here
    console.log(`${type}: ${message}`);
}

// Helper function to update cart count
function updateCartCount(count) {
    const cartCountElement = document.querySelector('.cart-count');
    if(cartCountElement) {
        cartCountElement.textContent = count;
    }
}