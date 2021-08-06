class TrieNode
{
  late Map<String, TrieNode> children;
  late bool isEndOfWord;
  late dynamic data;

  TrieNode({dynamic data})
  {
    this.children = {};
    this.isEndOfWord = false;
    this.data = data;
  }



  @override
  String toString()
  {
    return "TrieNode: {isEndOfWord: ${this.isEndOfWord}, " +
                      "children.keys:${this.children.keys.toList()}}";
  }
}
