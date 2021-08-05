import 'package:Stryde/data_structures/trie/TrieNode.dart';

class Trie
{
  late TrieNode root;
  late bool onlyAllowLowercase;

  /*
    Time Complexity: O(l*n) where l is the length of the longest word
                              and n is the number of words
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
      }

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

    // Mark last node as a leaf with data
    curNode.isEndOfWord = true;
    curNode.data = data;
  }

  // Time Complexity: O(2*l) where l is the length of str
  void remove(String str)
  {
    String curLetter = "";
    TrieNode curNode = this.root;
    Map<String, TrieNode> nodesToRemove = {};

    // Loop over each letter in str
    for (int i = 0; i < str.length; i++)
    {
      // Set the current letter
      curLetter = str[i];

      // Create a node if there are no children for that letter
      if (curNode.children[curLetter] == null)
      {
        return;
      }

      // Add curNode to list of nodes to delete
      if (!curNode.isEndOfWord)
      {
        nodesToRemove[curLetter] = curNode;
      }
      // Remove all prior nodes from list of nodes to delete
      else
      {
        nodesToRemove = {};
      }

      // Go to the child for the current letter
      TrieNode? nextNode = curNode.children[curLetter];
      if (nextNode != null)
      {
        curNode = nextNode;
      }
    }

    // Remove all nodes in str that are not part of a smaller word
    for (String key in nodesToRemove.keys)
    {
      TrieNode? nodeToRemoveFrom = nodesToRemove[key];
      if (nodeToRemoveFrom != null)
      {
        nodeToRemoveFrom.children.remove(key);
      }
    }
  }



  // Time Complexity: O(l) where l is the length of str
  bool search(String str)
  {
    TrieNode? node = _getNode(str);

    // The final letter is a leaf node
    return (node != null && node.isEndOfWord);
  }

  // See search
  bool hasWord(String str)
  {
    return search(str);
  }

  // Time Complexity: O(l) where l is the length of str
  bool startsWith(String prefix)
  {
    TrieNode? node = _getNode(prefix);
    return (node != null);
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



  /*
    Time Complexity: O(v+e) where v is the number of vertices/nodes
                              and e is the number of edges
    Returns all words as a list
  */
  List<String> toList()
  {
    List<String> output = _depthFirstSearch(this.root, "", {}, []);
    return output;
  }

  /*
   Time Complexity: O(v+e) where v is the number of vertices/nodes
                             and e is the number of edges
  */
  List<String> _depthFirstSearch(TrieNode curNode, String curStr, 
                                 Map<String, bool> visited, 
                                 List<String> output)
  {
    // Set up helper variables
    Map<String, TrieNode> children = curNode.children;
    visited[curStr] = true;

    // Iterate over each letter
    for (String curLetter in children.keys)
    {
      // Node has not been visited yet
      if (visited[curStr + curLetter] != null && 
          visited[curStr + curLetter] != true)
      {
        TrieNode? newNode = children[curLetter];
        if (newNode != null)
        {
          // Add word to output
          if (newNode.isEndOfWord)
          {
            output.add(curStr + curLetter);
          }

          // Loop over children
          output = _depthFirstSearch(newNode, curStr + curLetter, 
                                     visited, output);
        }
      }
    }

    return output;
  }



  // Time Complexity: O(l) where l is the length of str
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
