module CarbonMU

  class MyPersist
    include Persistable

    field :foo
  end

  class PersistCommand < Command
    syntax "persist"

    def execute(context)
      p = MyPersist.new
      p.foo = "hi"
      p.save
    end
  end
end
