<style>
    .ft__list li a:hover{
        color: #3f5caf;
    }
    .social__link li a i:hover{
        background:#3f5caf;
    }
</style>
<footer id="htc__footer">
            <!-- Start Footer Widget -->
            <div class="footer__container bg__cat--1">
                <div class="container">
                    <div class="row">
                        <!-- Start Single Footer Widget -->
                        <div class="col-md-3 col-sm-6 col-xs-12">
                            <div class="footer">
                                <h2 class="title__line--2">ABOUT US</h2>
                                <div class="ft__details">
                                    <p>Electronix is an E-Commerce Website of Electronic Gadgets. Gadgets like Mobile, Laptop, Tablet and TV are available at a very affordable and reasonable prices.</p>
                                    <div class="ft__social__link">
                                        <ul class="social__link">
                                            <li><a href="#"><i class="icon-social-twitter icons"></i></a></li>

                                            <li><a href="#"><i class="icon-social-instagram icons"></i></a></li>

                                            <li><a href="#"><i class="icon-social-facebook icons"></i></a></li>

                                            <li><a href="#"><i class="icon-social-google icons"></i></a></li>

                                            <li><a href="#"><i class="icon-social-linkedin icons"></i></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- End Single Footer Widget -->
                        <!-- Start Single Footer Widget -->
                        <div class="col-md-2 col-sm-6 col-xs-12 xmt-40 smt-40">
                            <div class="footer">
                                <h2 class="title__line--2">my account</h2>
                                <div class="ft__inner">
                                    <ul class="ft__list">
                                        <li><a href="cart.php">My Cart</a></li>
                                        <li><a href="login.php">Login</a></li>
                                        <li><a href="wishlist.php">Wishlist</a></li>
                                        <li><a href="checkout.php">Checkout</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!-- End Single Footer Widget -->
                        <!-- Start Single Footer Widget -->
                        <div class="col-md-2 col-sm-6 col-xs-12 xmt-40 smt-40">
                            <div class="footer">
                                <h2 class="title__line--2">Our service</h2>
                                <div class="ft__inner">
                                    <ul class="ft__list">
                                        <li><a href="cart.php">My Cart</a></li>
                                        <li><a href="login.php">Login</a></li>
                                        <li><a href="wishlist.php">Wishlist</a></li>
                                        <li><a href="checkout.php">Checkout</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <a href="#"><img src="images/others/shape/paypol.png" alt="payment images"></a> <br><br>
                        <p style="color:white; font-weight: bolder">Copyright &copy; www.electronix.com | <?php echo date('Y')?> All Rights Reserved!</p>
                        <!-- End Single Footer Widget -->
                    </div>
                </div>
            </div>
            <!-- End Footer Widget -->
        </footer>
        <!-- End Footer Style -->
    </div>
    <!-- Body main wrapper end -->

    <!-- Placed js at the end of the document so the pages load faster -->

    <!-- jquery latest version -->
    <script src="js/vendor/jquery-3.2.1.min.js"></script>
    <!-- Bootstrap framework js -->
    <script src="js/bootstrap.min.js"></script>
    <!-- All js plugins included in this file. -->
    <script src="js/plugins.js"></script>
    <script src="js/slick.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <!-- Waypoints.min.js. -->
    <script src="js/waypoints.min.js"></script>
    <!-- Main js file that contents all jQuery plugins activation. -->
    <script src="js/main.js"></script>
	<script src="js/custom.js"></script>

<style>
#jood-launcher {
    position: fixed;
    bottom: 25px;
    right: 25px;
    width: 85px;
    height: 85px;
    background: #1e3a8a;
    color: white;
    font-size: 22px;
    font-weight: bold;
    border-radius: 50%;
    border: none;
    cursor: pointer;
    box-shadow: 0 8px 25px rgba(0,0,0,0.3);
    z-index: 9999;
}

#jood-chat {
    position: fixed;
    bottom: 130px;
    right: 25px;
    width: 360px;
    max-width: 95%;
    background: white;
    border-radius: 15px;
    box-shadow: 0 15px 40px rgba(0,0,0,0.2);
    display: none;
    flex-direction: column;
    overflow: hidden;
    z-index: 9999;
}

#jood-header {
    background: #1e3a8a;
    color: white;
    padding: 18px;
    font-size: 22px;
    font-weight: bold;
    text-align: center;
}

#jood-messages {
    height: 300px;
    overflow-y: auto;
    padding: 15px;
    font-size: 14px;
}

#jood-input-area {
    display: flex;
    border-top: 1px solid #eee;
}

#jood-input {
    flex: 1;
    border: none;
    padding: 12px;
    font-size: 14px;
}

#jood-send {
    background: #1e3a8a;
    color: white;
    border: none;
    padding: 0 20px;
    cursor: pointer;
}
</style>

<button id="jood-launcher">JooD+</button>

<div id="jood-chat">
    <div id="jood-header">JooD+</div>
    <div id="jood-messages"></div>
    <div id="jood-input-area">
        <input id="jood-input" placeholder="Ask JooD+ anything..." />
        <button id="jood-send">Send</button>
    </div>
</div>

<script>
const launcher = document.getElementById("jood-launcher");
const chat = document.getElementById("jood-chat");
const messages = document.getElementById("jood-messages");
const input = document.getElementById("jood-input");
const sendBtn = document.getElementById("jood-send");

launcher.onclick = () => {
    chat.style.display = chat.style.display === "flex" ? "none" : "flex";
};

function addMessage(sender, text) {
    const div = document.createElement("div");
    div.style.marginBottom = "10px";
    div.innerHTML = "<strong>" + sender + ":</strong> " + text;
    messages.appendChild(div);
    messages.scrollTop = messages.scrollHeight;
};

async function sendMessage() {
    const text = input.value.trim();
    if (!text) return;

    addMessage("You", text);
    input.value = "";

    const res = await fetch("/api/chat.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ message: text })
    });

    const data = await res.json();
    addMessage("JooD+", data.reply);
}

sendBtn.onclick = sendMessage;
input.addEventListener("keydown", e => {
    if (e.key === "Enter") sendMessage();
});

</script>


</body>

</html>
