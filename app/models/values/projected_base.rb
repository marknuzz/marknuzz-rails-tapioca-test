# frozen_string_literal: true
# typed: true

# Values module is by design a side-effect-free namespace that doesn't have access to
#  classes/modules in the rest of the project
module Values
  class ProjectedBase
    extend T::Helpers
    abstract!
  end
end
