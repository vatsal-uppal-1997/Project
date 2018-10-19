<%-- 
    Document   : index
    Created on : 18 Oct, 2018, 2:41:58 PM
    Author     : cereal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="bower_components/vue/dist/vue.js"></script>
        <script src="bower_components/axios/dist/axios.min.js"></script>
        <script src="bower_components/qs/dist/qs.min.js"></script>
        <link rel="stylesheet" type="text/css" href="bower_components/bulma/css/bulma.min.css">
        <style>
            .slide-fade-enter-active {
                transition: all .3s ease;
            }
            .slide-fade-leave-active {
                transition: all .8s cubic-bezier(1.0, 0.5, 0.8, 1.0);
            }
            .slide-fade-enter, .slide-fade-leave-to
            /* .slide-fade-leave-active below version 2.1.8 */ {
                transform: translateX(10px);
                opacity: 0;
            }
        </style>
        <title>Login</title>
    </head>
    <body>
        <section class="hero is-primary is-medium">
            <!-- Hero head: will stick at the top -->
            <div class="hero-head">
                <nav class="navbar">
                    <div class="container">
                        <div class="navbar-brand">
                            <a class="navbar-item heading is-size-4">
                                Easy Rentals
                            </a>
                            <span class="navbar-burger burger" data-target="navbarMenuHeroA">
                                <span></span>
                                <span></span>
                                <span></span>
                            </span>
                        </div>
                        <div id="navbarMenuHeroA" class="navbar-menu">
                            <div class="navbar-end">
                                <a class="navbar-item is-active">
                                    Home
                                </a>
                                <a class="navbar-item">
                                    Testimonials
                                </a>
                                <a class="navbar-item">
                                    About Us
                                </a>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>

            <!-- Hero content: will be in the middle -->
            <div class="hero-body">
                <div class="container has-text-centered">
                    <h1 class="title">
                        Appartmental Rental Services
                    </h1>
                    <h2 class="subtitle">
                        One-Stop Solution For All Your Renting Headaches
                    </h2>
                </div>
            </div>

            <!-- Hero footer: will stick at the bottom -->
            <div class="hero-foot">
                <nav class="tabs">
                    <div class="container app2">
                        <ul>
                            <li class="is-active"><a v-on:click="displayLogin">Login</a></li>
                            <li><a v-on:click="displayRegister">Sign Up</a></li>
                        </ul>
                    </div>
            </div>
        </nav>
    </div>
</section>
<section class="section app3" style="padding: 9rem 1.5rem;">
    <transition name="slide-fade">
        <div class="container is-mobile" v-if="login">
            <form id="login" @submit.prevent="loginForm">
                <div class="field">
                    <label class="label"> Username </label>
                    <div class="control">
                        <input class="input" type="text" name="username" v-model="username">
                    </div>
                </div>
                <div class="field">
                    <label class="label"> Password </label>
                    <div class="control">
                        <input class="input" type="password" name="password" v-model="password">
                    </div>
                </div>
                <div class="field">
                    <div class="control">
                        <input class="button" type="submit">
                    </div>
                </div>
                <div class="notification is-danger" v-if="seen">
                    {{text}}
                </div>
            </form>
        </div>
    </transition>
    <transition name="slide-fade">
        <div class="container is-mobile" v-if="register">
            <form id="register" @submit.prevent="registerForm">
                <div class="field">
                    <label class="label"> Username </label>
                    <div class="control">
                        <input class="input" type="text" name="username" v-model="username" required="required">
                    </div>
                </div>
                <div class="field">
                    <label class="label"> E-Mail </label>
                    <div class="control">
                        <input class="input" type="email" name="email" v-model="email" required="required">
                    </div>
                </div>
                <div class="field">
                    <label class="label"> City </label>
                    <div class="control">
                        <input class="input" type="text" name="city" v-model="city" required="required">
                    </div>
                </div>
                <div class="field">
                    <label class="label"> Password </label>
                    <div class="control">
                        <input class="input" type="password" name="password" v-model="password" required="required">
                    </div>
                </div>
                <div class="field">
                    <label class="label"> Confirm Password </label>
                    <div class="control">
                        <input class="input" type="password" v-model="confirmPassword" required="required">
                    </div>
                    <p class="help is-danger triggerPassword" v-if="mismatch">The entered password does not match !</p>
                </div>
                <div class="field">
                    <div class="control">
                        <input class="button" type="submit">
                    </div>
                </div>
                <div class="notification is-danger" v-if="seen">
                    {{text}}
                </div>
            </form>
        </div>
    </transition>
</section>
<script>
//    const app = new Vue({
//        el: '#login',
//        data: {
//            username: '',
//            password: '',
//            seen: false,
//            text: ''
//        },
//        methods: {
//            processForm: function () {
//                console.log(this.username + " " + this.password);
//                const params = new URLSearchParams();
//                if (this.username === '' || this.password === '') {
//                    this.text = "Username or Password cannot be empty !";
//                    this.seen = true;
//                    return;
//                }
//                params.append("username", this.username);
//                params.append("password", this.password);
//                axios.post("login.jsp", params).then(resp => {
//                    console.log(resp);
//                    if (resp.data['message'] === "password invalid !") {
//                        this.seen = true;
//                    } else {
//                        this.seen = false;
//                    }
//                });
//            }
//        }
//    });
const app3 = new Vue({
    el: ".app2",
    data: {
        login: true,
        register: false
    },
    methods: {
        displayLogin: function () {
            app2.login = true;
            app2.register = false;
        },
        displayRegister: function () {
            app2.login = false;
            app2.register = true;
        }
    }
});
const app2 = new Vue({
    el: ".app3",
    data: {
        username: '',
        password: '',
        confirmPassword: '',
        email: '',
        city: '',
        text: '',
        seen: false,
        login: true,
        register: false,
        mismatch: false
    },
    methods: {
        loginForm: function () {
            console.log(this.username + " " + this.password);
            const params = new URLSearchParams();
            if (this.username === '' || this.password === '') {
                this.text = "Username or Password cannot be empty !";
                this.seen = true;
                return;
            }
            params.append("username", this.username);
            params.append("password", this.password);
            axios.post("login.jsp", params).then(resp => {
                console.log(resp);
                if (resp.data['message'] === "password invalid !") {
                    this.seen = true;
                    this.text = "Username or Password invalid !";
                } else {
                    window.location.href = resp.data["redirect"];
                    this.seen = false;
                }
            });
        },
        registerForm: function() {
            if (this.confirmPassword !== this.password) {
                this.mismatch = true;
                return;
            } else {
                this.mismatch = false;
            }
            const params = new URLSearchParams();
            params.append("username", this.username);
            params.append("password", this.password);
            params.append("city", this.city);
            params.append("email", this.email);
            axios.post("register.jsp", params).then(resp => {
                console.log(resp);
                switch(resp.data['message']) {
                    case "The user already exists !": {
                        this.text = "The user already exists !";
                        this.seen = true;
                        break;
                    }
                    case "The email already exists !": {
                            this.text = "The email already exists !";
                            this.seen = true;
                            break;
                    }
                    case "Some error occured !": {
                            this.text = "Some error occured !";
                            this.seen = true;
                            break;
                    }
                    case "User registered successfully !": {
                            window.location.href = resp.data["redirect"];
                            this.text = "User registered successfully !";
                            // todo redirect
                            break;
                    }
                }
            });
        }
    }
});
</script>
</body>
</html>
