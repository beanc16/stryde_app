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
}
