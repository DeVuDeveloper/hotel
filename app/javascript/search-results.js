document.addEventListener("turbo:load", function() {
    const searchForm = document.getElementById("search-form");
    const searchInput = document.getElementById("search-query");
    const searchResults = document.getElementById("search-results");
    const clearSearch = document.getElementById("clear-search");
    let resultsVisible = false;

    clearSearch.addEventListener("click", function() {
        searchInput.value = "";
        searchResults.classList.add("hidden");
      });
  
    searchForm.addEventListener("submit", async function(event) {
      event.preventDefault();
      const query = searchInput.value;
  
      try {
        const response = await fetch(`/search?query=${query}`);
        if (!response.ok) {
          throw new Error(`HTTP error! Status: ${response.status}`);
        }
  
        const data = await response.json();
  
        displaySearchResults(data);

        searchResults.classList.remove("hidden");
        resultsVisible = true;
      } catch (error) {
        console.error("Some error occured:", error);
      }
    });
  
  
    function displaySearchResults(results) {
      searchResults.innerHTML = "";
      if (results.length === 0) {
        searchResults.innerHTML = "Results not found.";
        return;
      }
  
      results.forEach(function(result) {
        const resultItem = document.createElement("div");
        resultItem.classList.add("search-result");
        resultItem.innerHTML = `
          <h2><a href="/rooms/" class="bold-text">${result._source.name}</a></h2>
          <p>${result._source.description}</p>
        `;
        searchResults.appendChild(resultItem);
      });
      
      
    }
  });
  