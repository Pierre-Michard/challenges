module Drivy
  module Storable

    attr_reader :all

    def init(items)
      @all = items.map{|item| new(item)}
    end

    def find(id)
      @all.detect{|el| el.id == id}
    end
  end
end