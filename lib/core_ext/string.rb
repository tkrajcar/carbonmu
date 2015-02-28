class String
  def collectionize
    split(":").last.tableize # Don't put module name in default Mongoid collection names.
  end
end
