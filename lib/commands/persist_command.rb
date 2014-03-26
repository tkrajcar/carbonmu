module CarbonMU

  class MyPersist
    include Persistable

    field :foo
  end

  class PersistCommand < Command
    command do
      p = MyPersist.new
      p.foo = "hi"
      p.save
    end
  end
end
