class Level {
  int _currentLevel;
  int _maxLevel;

  Level(this._currentLevel, this._maxLevel);

  int get currentLevel => _currentLevel;

  int get maxLevel => _maxLevel;

  bool isMaxLevel() {
    return _currentLevel >= _maxLevel;
  }

  void increaseLevel() {
    if (!isMaxLevel()) {
      _currentLevel++;
    }
  }

  void decreaseLevel() {
    if (_currentLevel > 1) {
      _currentLevel--;
    }
  }

  String getLevelText() {
    return "Level $_currentLevel";
  }
}
