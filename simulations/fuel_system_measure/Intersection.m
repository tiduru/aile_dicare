function t = Intersection(pt1,pt2,plane)
  t = nan;
  u = dot(pt1,plane(1:3)) - plane(4);    
  v = dot(pt2,plane(1:3)) - plane(4);    
  if (sign(u) ~= sign(v))
      t = (0-u) / (v-u);
  end
end