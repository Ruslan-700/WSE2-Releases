#Add to module_flora_kinds.py, next to the fkf_ flags (requires WSE2)

#Tags a flora kind with a terrain region variant (1-127), e.g. fkf_tree|fkf_plain|fkf_plain_forest|fkf_variant(1)|density(4)
#A scene with region variant N (the map face under the party in random battles, see scene_set_region_variant otherwise)
#uses only the kinds tagged fkf_variant(N) in each flora category (trees, bushes and rocks, grass) that has any for its terrain.
#Categories without tagged kinds keep the untagged flora. Tagged kinds never appear in scenes without their variant.
#Vanilla Warband ignores the tag and treats tagged kinds as normal flora of their terrain.
def fkf_variant(n):
  return n << 48
