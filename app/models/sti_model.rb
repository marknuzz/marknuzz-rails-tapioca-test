# frozen_string_literal: true
# typed: true

# STI is a firm requirement for this project
class StiModel < StiBase
  # PROBLEM (tapioca):
  #          Generates final.rbi:14: Final was declared as final but its
  #          method to_ary was not declared as final https://srb.help/5048
  #          14 |  def to_ary; end
  final!

  TProjection = type_template(:out) { { fixed: Values::ProjectedModel } }
  TProjectionInstance = type_member(:out) { { fixed: Values::ProjectedModel } }

  sig(:final) { override.returns(T::Class[TProjection]) }
  def self.projection_class
    Values::ProjectedModel
  end

  # PROBLEM: Every public method in the base class, even non-abstract methods, must be re-implemented like this
  #          with new sigs, and a cast, otherwise the returned type known by sorbet will be of the base class
  sig(:final) { override.returns(T.class_of(Values::ProjectedModel)) }
  def self.projection_class_non_generic
    # :(
    T.cast(super, T.class_of(Values::ProjectedModel))
  end

  sig(:final) { returns(Values::ProjectedModel)}
  def projection_non_generic
    # :(
    T.cast(super, Values::ProjectedModel)
  end
end
