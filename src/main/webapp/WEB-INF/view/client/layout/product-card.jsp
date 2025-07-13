<div class="col-md-6 col-lg-4 col-xl-3">
    <div class="rounded position-relative fruite-item"
         style="transition: all 0.3s ease; border: 1px solid #e9ecef; background: white; box-shadow: 0 2px 8px rgba(0,0,0,0.1);"
         onmouseover="this.style.transform='translateY(-5px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.15)'"
         onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 2px 8px rgba(0,0,0,0.1)'">

        <a href="/product/${product.id}" style="text-decoration: none; color: inherit;">
            <div class="fruite-img position-relative" style="overflow: hidden; border-radius: 8px 8px 0 0; height: 200px;">
                <img src="/images/product/${product.image}"
                     class="img-fluid w-100 h-100"
                     alt="${product.name}"
                     style="object-fit: cover; transition: transform 0.3s ease; border-radius: 8px 8px 0 0;"
                     onmouseover="this.style.transform='scale(1.1)'"
                     onmouseout="this.style.transform='scale(1)'">
            </div>

            <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                 style="top: 10px; left: 10px; font-size: 0.8rem; font-weight: 500; z-index: 2;">
                ${product.target}
            </div>

            <div class="p-4 border-top-0 rounded-bottom d-flex flex-column"
                 style="height: 260px; border-radius: 0 0 8px 8px;">

                <h4 class="text-truncate mb-3"
                    title="${product.name}"
                    style="font-size: 1.1rem; font-weight: 600; color: #2c3e50; line-height: 1.3;">
                    ${product.name}
                </h4>

                <p class="flex-grow-1 mb-3"
                   style="display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; line-height: 1.5em; max-height: 4.5em; color: #6c757d; font-size: 0.9rem;"
                   title="${product.shortDesc}">
                    ${product.shortDesc}
                </p>

                <div class="d-flex justify-content-between align-items-center mt-auto">
                    <p class="text-dark fs-5 fw-bold mb-0"
                       style="color: #e74c3c !important; font-size: 1.2rem;">
                        <fmt:formatNumber value="${product.price}" pattern="#,###"/>
                    </p>
                </div>
            </div>
        </a>

        <div class="position-absolute" style="bottom: 20px; right: 20px; z-index: 10;">
            <a href="#"
               class="btn border border-secondary rounded-pill px-3 text-primary d-flex align-items-center"
               style="font-size: 0.85rem; padding: 0.5rem 1rem; transition: all 0.3s ease; text-decoration: none;"
               onmouseover="this.style.backgroundColor='#28a745'; this.style.borderColor='#28a745'; this.style.color='white'; this.style.transform='scale(1.05)'"
               onmouseout="this.style.backgroundColor='transparent'; this.style.borderColor='#6c757d'; this.style.color='#007bff'; this.style.transform='scale(1)'"
               onclick="addToCart(${product.id}); return false;">
                <i class="fa fa-shopping-bag me-2"></i>
                Add
            </a>
        </div>
    </div>
</div>