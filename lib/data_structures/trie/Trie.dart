import 'package:Stryde/data_structures/trie/TrieNode.dart';

class Trie
{
  late TrieNode root;
  late bool onlyAllowLowercase;

  /*
    Time Complexity: O(l*n) where l is the length of the longest word
                              and n is the number of words
    Or:              O(1) if no words are added upon initialization
  */
  Trie({
    List<String> words = const [],
    bool onlyAllowLowercase = false,
  })
  {
    this.root = TrieNode();
    this.onlyAllowLowercase = onlyAllowLowercase;

    // Initialize words if they exist
    if (words.length > 0)
    {
      for (int i = 0; i < words.length; i++)
      {
        this.insert(words[i]);
      }
    }
  }

  /*
    Time Complexity: O(l*n) where l is the length of the longest word
                              and n is the number of words
    Or:              O(1) if no words are added upon initialization
  */
  Trie.withData({
    Map<String, dynamic> words = const {},
    bool onlyAllowLowercase = false,
  })
  {
    this.root = TrieNode();
    this.onlyAllowLowercase = onlyAllowLowercase;

    // Initialize words if they exist
    if (words.length > 0)
    {
      Trie trie = this;
      words.forEach((key, value)
      {
        trie.insert(key, data: value);
      });
    }
  }



  // Time Complexity: O(l) where l is the length of str
  void insert(String str, {dynamic data})
  {
    String curLetter = "";
    TrieNode curNode = this.root;

    // Loop over each letter in str
    for (int i = 0; i < str.length; i++)
    {
      // Set the current letter
      curLetter = str[i];
      if (this.onlyAllowLowercase)
      {
        curLetter = curLetter.toLowerCase();

        // Create a node if there are no children for that letter
        if (curNode.children[curLetter] == null)
        {
          curNode.children[curLetter] = new TrieNode();
        }

        // Go to the child for the current letter
        TrieNode? nextNode = curNode.children[curLetter];
        if (nextNode != null)
        {
          curNode = nextNode;
        }
      }
    }

    // Mark last node as a leaf with data
    curNode.isEndOfWord = true;
    curNode.data = data;
  }



  // Time Complexity: O(l) where l is the length of str
  bool search(String str)
  {
    TrieNode? node = _getNode(str);

    // The final letter is a leaf node
    return (node != null && node.isEndOfWord);
  }

  // Time Complexity: O(l) where l is the length of str
  dynamic getData(String str)
  {
    TrieNode? node = _getNode(str);

    if (node == null)
    {
      return null;
    }

    return node.data;
  }



  TrieNode? _getNode(String str)
  {
    String curLetter;
    TrieNode curNode = this.root;

    // Loop over each letter in str
    for (int i = 0; i < str.length; i++)
    {
      curLetter = str[i];

      // There are currently no children with that letter
      if (curNode.children[curLetter] == null)
      {
        return null;
      }

      // Go to the child for the current letter
      TrieNode? nextNode = curNode.children[curLetter];
      if (nextNode != null)
      {
        curNode = nextNode;
      }
    }

    return curNode;
  }
}
