module CarbonMU

  class MyPersist
    include Persistable

    field :foo
  end

  class PersistCommand
    c = Command.new(prefix: :persist) do
      p = MyPersist.new
      p.foo = "hi"
      p.save
    end
    CommandManager.add(c)
  end
end
