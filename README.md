# vertical

개발 과정 로그

- DateTime
- Grid View
- GridView.builder(gridDelegate, itemCount, itemBuilder)
- CustomScrollView(slivers: [SliverGrid(gridDelegate, delegate)])
- 세로, 가로 달력 제작 - ListView.builder(scrollDirection, itemCount, itemBuilder)
- List<Widget>.from(week);
- week.clear();
- collection for/if
- changeNotifierProvider / listenableBuilder > changeNotify

for(var week in weeks) ...[
Row(),
Row(),
]

...List.generate(number, fn);

- 다크모드 적용
  themeController / themeService
