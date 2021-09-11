// Some department belong to other department

class DeptDept {
  int? id;
  int? above;
  int? below;

  DeptDept(this.above, this.below);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['above_dept_id'] = above;
    map['below_dept_id'] = below;
    if (id != null) map['id'] = id;

    return map;
  }

  DeptDept.fromObject(dynamic obj) {
    id = obj['id'];
    below = obj['above_dept_id'];
    below = obj['below_dept_id'];
  }
}
