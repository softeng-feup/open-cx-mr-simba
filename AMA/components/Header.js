import React, { useState } from 'react';
import { StyleSheet, Text, View, Button, TextInput } from 'react-native';


import Colors from '../constants/Colors';

const Header = props => {
    return (
    <View style={styles.header}>
        <Text style={styles.title}> 
            {props.title}
        </Text>
    </View>
    );
}


const styles = StyleSheet.create({
    header: {
        backgroundColor: 'blue',
        width: '100%',
        height: 100,
        paddingTop: 36,
        alignItems: 'center',
        justifyContent: 'center'
    },

    title: {
        color: 'white',
        fontSize: 30
    }

});


export default Header;