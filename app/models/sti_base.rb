# frozen_string_literal: true
# typed: true

# STI is a firm requirement for this project
class StiBase < ActiveRecord::Base
  extend T::Helpers
  extend T::Sig
  extend T::Generic
  abstract!

  TProjection = type_template(:out) { { upper: Values::ProjectedBase } }

  sig { abstract.returns(T::Class[TProjection]) }
  def self.projection_class; end

  sig { returns(TProjection) }
  def projection_doesnt_work_1
    # PROBLEM (sorbet-generic):
    #    `type_template` type `TProjection` used in an instance method definition https://srb.help/5072
    # Quoted: "The solution is to instead specify both type_member and a type_template, and have the child class fix both of them:"
    self.class.projection_class.new
  end

  # So following the solution, causes a tapioca problem:
  # PROBLEM (tapioca): 100 errors of "Malformed type declaration. Generic class without type arguments"
  #         Elem = type_member { { fixed: ::StiBase } }
  TProjectionInstance = type_member(:out) { { upper: Values::ProjectedBase } }

  # Additionally: Here's another frustration with the "solution"
  sig { returns(TProjectionInstance)}
  def projection_doesnt_work_2
    # PROBLEM (sorbet-generic):
    #    (related to above) No way to signal to sorbet that TProjection will always equal TProjectionInstance
    #    error: Expected `StiBase::TProjectionInstance` but found `ProjectedBase` for method result type
    #    https://srb.help/7005
    self.class.projection_class.new
  end

  # Okay, it should be fine to get away with *just* one more method here for instanced contexts
  # even though it is a bit of a code smell, its hidden away in the abstract class and won't add complexity
  sig(:final) { returns(T::Class[TProjectionInstance]) }
  def projection_class
    T.cast(self.class.projection_class, T::Class[TProjectionInstance])
  end

  sig { returns(TProjectionInstance)}
  def projection
    projection_class.new
  end

  # But we still have the problem of tapioca rbi failures when using type_member
  # So let's abandon the idea of generics for now:
  sig { abstract.returns(T.class_of(Values::ProjectedBase)) }
  def self.projection_class_non_generic; end

  sig { returns(Values::ProjectedBase)}
  def projection_non_generic
    # PROBLEM: Using non generic alternative means every public subclass method needs to re-implement
    #          with new sig, and cast from Values::ProjectedBase to Values::ProjectedModel (or appropriate type)
    self.class.projection_class_non_generic.new
  end
end
