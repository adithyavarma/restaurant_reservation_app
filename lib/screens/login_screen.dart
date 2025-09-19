import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

     _tabController.addListener(() {
    if (_tabController.indexIsChanging) {
      _emailController.clear();
      _phoneController.clear();
      _passwordController.clear();
    }
  });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
}

  void _login() {
    if (_formKey.currentState!.validate()) {
      String loginMethod =
          _tabController.index == 0 ? "Email: ${_emailController.text}" : "Phone: ${_phoneController.text}";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logging in with $loginMethod")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 500,
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Welcome back",
                    style: TextStyle(
                      fontSize: 32, 
                      fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Sign in to your account to continue",
                    style: TextStyle(fontSize: 16, color: Colors.black54, height: 1.5),
                  ),
                  const SizedBox(height: 22),
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: Colors.grey.shade200),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 56,
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),  
                              ),
                              child: TabBar(
                                controller: _tabController,
                                
                                indicator: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey.shade300),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.06),
                                      blurRadius: 2,
                                      offset: Offset(0, 1),
                                      
                                    )
                                  ],
                                ),
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicatorColor: Colors.transparent,
                                indicatorWeight: 0,
                                dividerColor: Colors.transparent,
                                labelColor: Colors.black,
                                unselectedLabelColor: Colors.grey,
                                tabs: const [
                                  Tab(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.email_outlined),
                                        SizedBox(width: 8),
                                        Text("Email"),
                                      ],
                                    ),
                                  ),
                                  Tab(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.phone_outlined),
                                        SizedBox(width: 8),
                                        Text("Phone"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 220,
                              
                              child: TabBarView(
                                controller: _tabController,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  // Email tab
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Email address",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:16,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      TextFormField(
                                        controller: _emailController,
                                        decoration: InputDecoration(
                                          // labelText: "Email address",
                                          // hintText: "Enter your email address",
                                          filled: true,
                                          fillColor: Colors.grey.shade200,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please enter your email";
                                          }
                                          final pattern = r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                                          final regExp = RegExp(pattern);
                                          if (!regExp.hasMatch(value)) {
                                            return "Enter a valid email";
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 12),
                                      _buildPasswordField(),
                                    ],
                                  ),
                                  // Phone tab
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Phone number",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:16,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      TextFormField(
                                        controller: _phoneController,
                                        decoration: InputDecoration(
                                          // labelText: "Phone number",
                                          // hintText: "Enter your phone number",
                                          filled: true,
                                          fillColor: Colors.grey.shade200,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please enter your phone number";
                                          }
                                          if (value.length < 10) {
                                            return "Enter a valid phone number";
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 12),
                                      _buildPasswordField(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              height:50,
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.lock_outline),
                                label: const Text("Sign in"),
                                onPressed: _login,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  textStyle: const TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            const SizedBox(height: 12),

                            Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed:(){
                                  // Add forgot password navigation
                                },
                                child: const Text(
                                  "Forgot your password?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold, 
                                    fontSize: 15,
                                    color: Colors.black87,
                                    ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Password",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 8),
      TextFormField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          // hintText: "Enter your password",
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your password";
          }
          if (value.length < 6) {
            return "Password must be at least 6 characters";
          }
          return null;
        },
      ),
    ],
  );
  }
}
