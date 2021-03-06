module TMustache.Relation.Order

%default total
%access public export

interface StrictOrder (lt : a -> a -> Type) where

  irreflexive : lt x x -> Void
  transitive  : lt x y -> lt y z -> lt x z

data Trichotomy : (ltR : a -> a -> Type) -> a -> a -> Type where
  LT : ltR x y -> Trichotomy ltR x y
  EQ : x = y   -> Trichotomy ltR x y
  GT : ltR y x -> Trichotomy ltR x y

interface StrictOrder ltR =>
          TotalStrictOrder (ltR : a -> a -> Type) where

  trichotomy : (x, y : a) -> Trichotomy ltR x y

compareBy : (ltR : a -> a -> Type) -> TotalStrictOrder ltR =>
            (x, y : a) -> Trichotomy ltR x y
compareBy _ = trichotomy

ymotohcirt : Trichotomy ltR x y -> Trichotomy ltR y x
ymotohcirt (LT pr) = GT pr
ymotohcirt (EQ eq) = EQ $ sym eq
ymotohcirt (GT pr) = LT pr
