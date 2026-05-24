  import 'package:alice/models/ads/ads.dart';
import 'package:flutter/material.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class CreatePostData {
  final String title;
  final String description;
  final List<String> images;
  final String? category;
  final String? standardProductId;
  final List<String> hashtags;

  CreatePostData({
    required this.title,
    required this.description,
    required this.images,
    this.category,
    this.standardProductId,
    required this.hashtags,
  });

}

void showCreatePostSheet(
  BuildContext context, {
  Ads? add,
  required Function(CreatePostData data) onPost,
  required Function(CreatePostData data)? onSave,
}) {
  final isEditing = add != null;
  
  final titleKey = GlobalKey<_CreatePostFieldState>();
  final descriptionKey = GlobalKey<_CreatePostFieldState>();
  final photoKey = GlobalKey<_PhotoPickerRowState>();
  final categoryKey = GlobalKey<_CategoryRowState>();
  final productKey = GlobalKey<_StandardProductSelectorState>();
  final hashtagKey = GlobalKey<_HashtagsInputState>();

  CreatePostData collectFormData() => CreatePostData(
      title: titleKey.currentState?.getValue() ?? '',
      description: descriptionKey.currentState?.getValue() ?? '',
      images: photoKey.currentState?.getImages() ?? [],
      category: categoryKey.currentState?.getCategory(),
      standardProductId: productKey.currentState?.getProductId(),
      hashtags: hashtagKey.currentState?.getHashtags() ?? [],
    );

  WoltModalSheet.show(
    context: context,
    barrierDismissible: true,
    enableDrag: true,
    showDragHandle: false,
    useSafeArea: true,
    modalBarrierColor: Colors.black.withAlpha(92),
    modalTypeBuilder: (_) => const WoltBottomSheetType(
      shapeBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
    ),
    pageListBuilder: (bottomSheetContext) => [
      SliverWoltModalSheetPage(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        navBarHeight: 80,
        hasTopBarLayer: true,
        isTopBarLayerAlwaysVisible: true,
        topBar: _CreatePostHeader(
          isEditing: isEditing,
          onCancel: () => Navigator.of(bottomSheetContext).pop(),
          onPost: () {
            final data = collectFormData();
            onPost(data);
            Navigator.of(bottomSheetContext).pop();
          },
          onSave: onSave != null
              ? () {
                  final data = collectFormData();
                  onSave(data);
                  Navigator.of(bottomSheetContext).pop();
                }
              : null,
        ),
        mainContentSliversBuilder: (_) => [
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _CreatePostLabel('TITLE'),
                      const SizedBox(height: 12),
                      _CreatePostField(
                        key: titleKey,
                        height: 76,
                        placeholder: 'Give your treat a name',
                        initialValue: add?.title,
                      ),
                      const SizedBox(height: 34),
                      const _CreatePostLabel('DESCRIPTION'),
                      const SizedBox(height: 12),
                      _CreatePostField(
                        key: descriptionKey,
                        height: 192,
                        placeholder: 'Describe the flavors, ingredients...',
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.fromLTRB(24, 22, 24, 18),
                        initialValue: add?.description,
                      ),
                      const SizedBox(height: 42),
                      const _CreatePostLabel('ADD PHOTOS'),
                      const SizedBox(height: 14),
                      _PhotoPickerRow(
                        key: photoKey,
                        initialImages: add?.images,
                      ),
                      const SizedBox(height: 44),
                      const _CreatePostLabel('CATEGORY'),
                      const SizedBox(height: 14),
                      _CategoryRow(
                        key: categoryKey,
                        initialCategory: add?.category,
                      ),
                      const SizedBox(height: 26),
                      const _CreatePostLabel('STANDARD PRODUCT'),
                      const SizedBox(height: 14),
                      _StandardProductSelector(
                        key: productKey,
                        initialProductId: add?.standardProductId,
                      ),
                      const SizedBox(height: 26),
                      const _CreatePostLabel('HASHTAGS'),
                      const SizedBox(height: 14),
                      _HashtagsInput(
                        key: hashtagKey,
                        initialHashtags: add?.tags,
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

class _CreatePostHeader extends StatelessWidget {
  const _CreatePostHeader({
    required this.isEditing,
    required this.onCancel,
    required this.onPost,
    this.onSave,
  });

  final bool isEditing;
  final VoidCallback onCancel;
  final VoidCallback onPost;
  final VoidCallback? onSave;

  @override
  Widget build(BuildContext context) => Container(
    height: 96,
    padding: const EdgeInsets.symmetric(horizontal: 32),
    decoration: const BoxDecoration(
      color: Colors.white,
      border: Border(
        bottom: BorderSide(color: Color(0xFFFFDDF8)),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onCancel,
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Color(0xFF531900),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          isEditing ? 'Edit Post' : 'Create Post',
          style: const TextStyle(
            color: Color(0xFF531900),
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        GestureDetector(
          onTap: isEditing && onSave != null ? onSave : onPost,
          child: Text(
            isEditing ? 'Update' : 'Post',
            style: const TextStyle(
              color: Color(0xFF531900),
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    ),
  );
}

class _CreatePostLabel extends StatelessWidget {
  const _CreatePostLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) => Text(
    label,
    style: const TextStyle(
      color: Color(0xFFB8B8B8),
      fontSize: 12,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
    ),
  );
}

class _CreatePostField extends StatefulWidget {
  final double height;
  final String placeholder;
  final Alignment alignment;
  final EdgeInsets padding;
  final String? initialValue;

  const _CreatePostField({
    super.key,
    required this.height,
    required this.placeholder,
    this.alignment = Alignment.centerLeft,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    this.initialValue,
  });

  @override
  State<_CreatePostField> createState() => _CreatePostFieldState();
}

class _CreatePostFieldState extends State<_CreatePostField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String getValue() => _controller.text;

  @override
  Widget build(BuildContext context) => Container(
    height: widget.height,
    decoration: BoxDecoration(
      color: const Color(0xFFFAFAFA),
      border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
      borderRadius: BorderRadius.circular(16),
    ),
    child: TextField(
      controller: _controller,
      maxLines: null,
      expands: true,
      textAlignVertical: TextAlignVertical.top,
      style: const TextStyle(
        color: Color(0xFF2C2C2C),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: widget.placeholder,
        hintStyle: const TextStyle(
          color: Color(0xFF737373),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        border: InputBorder.none,
        contentPadding: widget.padding,
        prefixIconConstraints: const BoxConstraints(),
      ),
    ),
  );
}

class _PhotoPickerRow extends StatefulWidget {
  final List<String>? initialImages;

  const _PhotoPickerRow({this.initialImages, super.key});

  @override
  State<_PhotoPickerRow> createState() => _PhotoPickerRowState();
}

class _PhotoPickerRowState extends State<_PhotoPickerRow> {
  late final List<String> _selectedImages;

  @override
  void initState() {
    super.initState();
    _selectedImages = List.from(widget.initialImages ?? []);
  }

  void _addPhoto() {
    setState(() {
      _selectedImages.add('placeholder_${_selectedImages.length}');
    });
  }

  void _removePhoto(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  List<String> getImages() => List.from(_selectedImages);

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 140,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: _selectedImages.length + 1,
      separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (context, index) {
        if (index == _selectedImages.length) {
          return GestureDetector(
            onTap: _addPhoto,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFFF19DF),
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xFFFFF0FA),
              ),
              child: const Icon(
                Icons.add,
                color: Color(0xFFFF19DF),
                size: 32,
              ),
            ),
          );
        }

        return Stack(
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey[300],
              ),
              child: const Icon(
                Icons.image,
                color: Colors.grey,
                size: 40,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () => _removePhoto(index),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: Color(0xFF666666),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}
class _CategoryRow extends StatefulWidget {
  final String? initialCategory;

  const _CategoryRow({this.initialCategory, super.key});

  @override
  State<_CategoryRow> createState() => _CategoryRowState();
}

class _CategoryRowState extends State<_CategoryRow> {
  late String? _selectedCategory;
  
  final List<String> categories = [
    'Pastry',
    'Bakery',
    'Ice Cream Shop',
    'Coffee',
    'Desserts',
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
  }

  String? getCategory() => _selectedCategory;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List.generate(
        categories.length,
        (index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category;

          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => setState(() => _selectedCategory = category),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFFF19DF) : Colors.white,
                  border: Border.all(
                    color: isSelected ? const Color(0xFFFF19DF) : const Color(0xFFE8E8E8),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF2C2C2C),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
class _StandardProductSelector extends StatefulWidget {
  final String? initialProductId;


  const _StandardProductSelector({
    this.initialProductId,
    super.key
    });

  @override
  State<_StandardProductSelector> createState() =>
      _StandardProductSelectorState();
}

class _StandardProductSelectorState extends State<_StandardProductSelector> {
  late String? _selectedProduct;
  late String? _selectedProductId;

  // Dummy product list
  final List<Map<String, String>> _dummyProducts = [
    {'id': 'prod_001', 'name': 'Chocolate Cake'},
    {'id': 'prod_002', 'name': 'Strawberry Tart'},
    {'id': 'prod_003', 'name': 'Vanilla Cupcake'},
    {'id': 'prod_004', 'name': 'Lemon Pie'},
    {'id': 'prod_005', 'name': 'Cheesecake'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedProductId = widget.initialProductId;
    if (widget.initialProductId != null) {
      final product = _dummyProducts.firstWhere(
        (p) => p['id'] == widget.initialProductId,
        orElse: () => {'id': '', 'name': ''},
      );
      _selectedProduct = product['name'];
    } else {
      _selectedProduct = null;
    }
  }

  String? getProductId() => _selectedProductId;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => _showProductPicker(context),
    child: Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _selectedProduct ?? 'Select a product...',
            style: TextStyle(
              color: _selectedProduct != null
                  ? const Color(0xFF2C2C2C)
                  : const Color(0xFF737373),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFF737373),
            size: 24,
          ),
        ],
      ),
    ),
  );

  void _showProductPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SizedBox(
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Select Product',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: const Color(0xFF531900),
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: _dummyProducts.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (_, index) {
                  final product = _dummyProducts[index];
                  return ListTile(
                    title: Text(
                      product['name']!,
                      style: const TextStyle(
                        color: Color(0xFF2C2C2C),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedProduct = product['name'];
                        _selectedProductId = product['id'];
                      });
                      Navigator.pop(ctx);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HashtagsInput extends StatefulWidget {
  final List<String>? initialHashtags;

  const _HashtagsInput({this.initialHashtags,super.key});

  @override
  State<_HashtagsInput> createState() => _HashtagsInputState();
}

class _HashtagsInputState extends State<_HashtagsInput> {
  late final List<String> _hashtags;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _hashtags = List.from(widget.initialHashtags ?? []);
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addHashtag() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _hashtags.add(text);
        _controller.clear();
      });
    }
  }

  void _removeHashtag(int index) {
    setState(() {
      _hashtags.removeAt(index);
    });
  }

  List<String> getHashtags() => List.from(_hashtags);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 56,
        padding: const EdgeInsets.only(left: 20, right: 8, top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFA),
          border: Border.all(color: const Color(0xFFE8E8E8), width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Text(
              '#',
              style: TextStyle(
                color: Color(0xFFFF19DF),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 40,
                child: Center(
                  child: TextField(
                    controller: _controller,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF2C2C2C),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Add tags...',
                      hintStyle: TextStyle(
                        color: Color(0xFF737373),
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onSubmitted: (_) => _addHashtag(),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: _addHashtag,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF19DF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      if (_hashtags.isNotEmpty) ...[
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(
            _hashtags.length,
            (index) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFF19DF).withAlpha(25),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFFF19DF),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '#${_hashtags[index]}',
                    style: const TextStyle(
                      color: Color(0xFFFF19DF),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () => _removeHashtag(index),
                    child: const Icon(
                      Icons.close,
                      size: 14,
                      color: Color(0xFFFF19DF),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ],
  );
}