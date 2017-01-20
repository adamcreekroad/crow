module Jet
  class Array < Array
    def each(&block)
      %x{
        for (let item of this) {
          block(item);
        }
        return this;
      }
    end

    def each_with_index(&block)
      %x{
        for (let item of this) {
          const index = this.indexOf(item);
          block(item, index);
        }
        return this;
      }
    end

    def reject(&block)
      %x{
        let rejectedItems = [];

        for (let item of this) {
          const reject = block(item);

          if (reject) {
            rejectedItems.push(item);
          }
        }

        for (let item of rejectedItems) {
          this.splice(this.indexOf(item), 1);
        }

        return this;
      }
    end
  end
end
