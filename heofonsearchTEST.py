class HeofonSearch:
    def __init__(self):
        self.pages = []

    def add_page(self, title, url, content):
        self.pages.append({
            "title": title,
            "url": url,
            "content": content.lower()
        })

    def search(self, query):
        query = query.lower()

        results = []

        for page in self.pages:
            score = page["content"].count(query)

            if query in page["title"].lower():
                score += 10

            result = page.copy()
            result["score"] = score
            results.append(result)

        results = [
            page for page in results
            if page["score"] > 0
        ]

        results.sort(
            key=lambda page: page["score"],
            reverse=True
        )

        return results


# -------------------------
# Example
# -------------------------

search = HeofonSearch()

search.add_page(
    "Ruby Programming",
    "https://example.com/ruby",
    "Ruby is a fast programming language used for web development."
)

search.add_page(
    "Heofon Search",
    "https://heofonsearch.zite.so",
    "Heofon Search is a privacy focused search engine with its own search technology."
)

search.add_page(
    "Cats",
    "https://example.com/cats",
    "Cats are cute animals."
)

print("Search Results:\n")

for result in search.search("search"):
    print(result["title"])
    print(result["url"])
    print(f"Score: {result['score']}")
    print("-" * 40)
