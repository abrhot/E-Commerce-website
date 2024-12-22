const popularContainer = document.querySelector('.popular-container');
        let scrollAmount = 0;
        const scrollSpeed = 1;
        const scrollPause = 3000; // 3 seconds pause at each end
        let scrollDirection = 1;
        let isPaused = false;

        function autoScroll() {
            if (!isPaused) {
                scrollAmount += scrollSpeed * scrollDirection;
                popularContainer.scrollLeft = scrollAmount;

                // Check if reached the end
                if (scrollAmount >= (popularContainer.scrollWidth - popularContainer.clientWidth)) {
                    isPaused = true;
                    setTimeout(() => {
                        scrollDirection = -1;
                        isPaused = false;
                    }, scrollPause);
                }
                // Check if reached the start
                else if (scrollAmount <= 0) {
                    isPaused = true;
                    setTimeout(() => {
                        scrollDirection = 1;
                        isPaused = false;
                    }, scrollPause);
                }
            }
            requestAnimationFrame(autoScroll);
        }

        // Start auto-scroll
        autoScroll();

        // Pause auto-scroll on hover
        popularContainer.addEventListener('mouseenter', () => isPaused = true);
        popularContainer.addEventListener('mouseleave', () => isPaused = false);



