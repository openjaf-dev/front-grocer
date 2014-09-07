module ProductHelper

  class Tree
    attr_accessor :name,:children,:size
    def initialize(name = 'root')
      @name = name
      @children = []
      @size = 0
    end

    def add_child(tree)#tree=Tree.new
      @children << tree
    end

    def add_trees(collection)#["Categories","Clothes", "T-Shirts",50]
      #recursivity stop case
      if collection.length == 1
        @size = collection[0]
        return
      end

      #if exist a branch with the same name
      found_branch = false
      @children.each do |c|
        if c.name == collection[0]
          #take the branch and add the sub-tree
          c.add_trees(collection[1, collection.length - 1])
          found_branch = true
          break
        end
      end
      #if not, add a new branch to the tree
      unless found_branch
        t = Tree.new(collection[0])
        t.add_trees(collection[1, collection.length - 1])
        @children << t
      end

      #update size
      @size = @children.sum{ |x| x.size }
    end

    def is_leaf?
      @children.length == 0
    end

    def to_json
      if self.is_leaf?
        return "{\"name\":\"#{@name}\",\"size\":#{@size}}"
      end
      children_json = ''
      (0...@children.count).each do |c|
        if c == 0
          children_json += @children[c].to_json
        else
          children_json += ", #{@children[c].to_json}"
        end
      end

      json = "{\"name\":\"#{@name}\",\"children\":[#{children_json}]}"
    end

    def get_tags
      tags=[]
      if @name != 'root'
        tags << @name
      end

      @children.each{|x| tags += x.get_tags }
      tags
    end

    def Tree.build_tree(tree)# tree = Tree.new
      t = Tree.new
      t.children << tree
      t
    end

  end



end
